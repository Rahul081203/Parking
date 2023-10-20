import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReportIllegalScreen extends StatefulWidget {
  final String? userEmail;

  ReportIllegalScreen({this.userEmail});

  @override
  _ReportIllegalScreenState createState() => _ReportIllegalScreenState(userEmail: userEmail);
}

class _ReportIllegalScreenState extends State<ReportIllegalScreen> {
  final String? userEmail;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;
  bool _isImageTaken = false;
  String _latitude = '';
  String _longitude = '';

  _ReportIllegalScreenState({this.userEmail}); // Constructor to accept user's email

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndInitializeCamera();
  }

  Future<void> _requestPermissionsAndInitializeCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
      Permission.location,
    ].request();

    if (statuses[Permission.camera]!.isDenied ||
        statuses[Permission.location]!.isDenied) {
      // Handle when camera or location permission is denied.
      // You can show an error message or request the permission again.
    } else {
      // Proceed to initialize the camera
      await _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      _cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isTakingPicture) {
      try {
        final path = join(
          (await getTemporaryDirectory()).path,
          '${DateTime.now()}.png',
        );
        _capturedImage = await _cameraController!.takePicture();
        await _getCurrentLocation();

        setState(() {
          _isImageTaken = true;
        });

        _uploadToFirebase(); // Upload image and coordinates to Firebase
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> _uploadToFirebase() async {
    try {
      final CollectionReference reports = FirebaseFirestore.instance.collection('reports');
      final docRef = await reports.add({
        'Image': '', // Replace with the URL of the uploaded image
        'Location': GeoPoint(double.parse(_latitude), double.parse(_longitude)), // Use GeoPoint
        'Reporting Time': Timestamp.fromDate(DateTime.now().toUtc()),
        'User UID': '', // Add user's UID
        'User Email': userEmail, // Set the user's email
      });

      final imageBytes = File(_capturedImage!.path).readAsBytesSync();
      final storageRef = FirebaseStorage.instance.ref().child(docRef.id);
      final uploadTask = storageRef.putData(imageBytes);
      await uploadTask.whenComplete(() {});

      final imageURL = await storageRef.getDownloadURL();

      await docRef.update({'Image': imageURL});
    } catch (e) {
      print('Error uploading to Firebase: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCameraInitialized && _isImageTaken) {
      return Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.file(File(_capturedImage!.path)),
              Positioned(
                top: 16,
                left: 16,
                child: Text(
                  'Lat: $_latitude, Lng: $_longitude',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                // Accept the captured image
              },
              child: Icon(Icons.check),
            ),
            FloatingActionButton(
              onPressed: () {
                // Reject the captured image and retake the picture
                setState(() {
                  _isImageTaken = false;
                });
              },
              child: Icon(Icons.close),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    } else {
      return Scaffold(
        body: Center(
          child: _isCameraInitialized
              ? CameraPreview(_cameraController!)
              : CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _takePicture,
          child: Icon(Icons.camera),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }
}
