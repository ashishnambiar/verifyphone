import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:verifyphone/Screens/user_location_page.dart';

class VerificationCodeProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  loadingStart() {
    _loading = true;
    notifyListeners();
  }

  loadingDone() {
    _loading = false;
    notifyListeners();
  }

  String? _verificationId;
  bool inited = false;

  init(context) {
    if (!inited) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        print('*' * 100);
        if (user == null) {
          print('User is currently signed out!!');
          Navigator.popUntil(context, ModalRoute.withName('/'));
        } else {
          print('User is signed in!');
          Navigator.pushNamedAndRemoveUntil(
              context, UserLocationPage.route, ModalRoute.withName('/'));
        }
      });
      inited = true;
    }
  }

  Future<void> verifyNumber(
      {required String phoneNumber, required Function() afterCodeSent}) async {
    loadingStart();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {
        log('verification completed: $credential');
        loadingDone();
        FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('verification failed: $e');
        loadingDone();
      },
      codeSent: (String verificationId, int? resendToken) async {
        log('code sent: $verificationId');
        log('code sent: $resendToken ');

        _verificationId = verificationId;

        loadingDone();
        afterCodeSent();

        // Navigator.pushNamed(context, VerificationPage.route);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('code auto retrieval timeout: $verificationId');
        _verificationId = verificationId;
      },
    );
  }

  signInWithVerificationCode(String code) async {
    loadingStart();
    try {
      if (_verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code);
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e, st) {
      log('Error: $e');
      log('StackTrace: $st');
    } finally {
      loadingDone();
    }
  }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    log('Location: ${location.getLocation()}');
  }
}
