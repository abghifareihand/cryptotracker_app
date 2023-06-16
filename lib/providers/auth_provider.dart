import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptotracker_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (docSnapshot.exists) {
          Map<String, dynamic> userData =
              docSnapshot.data() as Map<String, dynamic>;

          _loggedInUser = UserModel(
            name: userData['name'],
            email: email,
            hobby: userData['hobby'],
          );
          notifyListeners();

          // Simpan data login ke penyimpanan lokal
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userName', userData['name']);

          return true; // Login berhasil
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(), gravity: ToastGravity.TOP);
    }

    return false; // Login gagal
  }

  Future<bool> register(
      String name, String email, String password, String hobby) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Jika register berhasil, tambahkan data ke Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'hobby': hobby,
        });

        // Navigasi ke halaman beranda setelah register berhasil
        _loggedInUser = UserModel(
          name: name,
          email: email,
          hobby: hobby,
        );
        notifyListeners();

        return true; // Registrasi berhasil
      }
    } on FirebaseAuthException catch (e) {
      // Menampilkan pesan error jika terjadi kesalahan
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.TOP,
      );
    }

    return false; // Registrasi gagal
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _loggedInUser = null;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Failed to logout. Please try again.',
          gravity: ToastGravity.TOP);
    }
  }
}
