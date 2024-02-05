import 'package:pause/service/firebase_service.dart';

class DatabaseService {
  Future<void> saveUserDataToDatabase(String email, String password) async {
    try {
      await FirebaseService.fireStore.collection('users').add({
        'email': email,
        'password': password,
      });
    } catch (error) {
      print('Error saving user data: $error');
    }
  }
}
