import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage storage = GetStorage();

  // Cek apakah sudah login
  bool get isLoggedIn => _auth.currentUser != null;
}
