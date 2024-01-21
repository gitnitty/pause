import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserDataToDatabase(String email, String password) async {
    try {
      // Add user data to Firestore
      await _firestore.collection('users').add({
        'email': email,
        'password': password,
        // You can add more fields as needed
      });

      // You can also retrieve the document ID if you need it
      // String documentId = result.id;

      // Continue with navigation or other actions
      // ...
    } catch (error) {
      print('Error saving user data: $error');
      // Handle errors as needed
    }
  }
}
