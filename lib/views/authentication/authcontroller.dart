import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// class AuthController{
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final FirebaseStorage _storage = FirebaseStorage.instance;

// _uploadProfileImageToStorage(Uint8List? image)async{

//  Reference ref =
 
//  _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
//  UploadTask uploadTask = ref.putData(image!);

//  TaskSnapshot snapshot = await  uploadTask;
//  String downloadUrl = await snapshot.ref.getDownloadURL();

//  return downloadUrl;
// }

// pickProfileImage(ImageSource source)async{
//   final ImagePicker _imagePicker = ImagePicker();

// XFile? _file = await  _imagePicker.pickImage(source: source);
// {

// }
// if(_file!=null){
//   return await _file.readAsBytes();
// }else{
//   print("No image selected");
// }

// }

//   Future<String> signUpUsers(String email,String fullName, String phoneNumber,
//    String password, Uint8List? image) async{

// String res = 'Some error occured';

// try {
//   if(email.isNotEmpty && fullName.isNotEmpty && password.isNotEmpty && phoneNumber.isNotEmpty && image !=null ){
//     //create the users
// UserCredential cred= await _auth.createUserWithEmailAndPassword(
//   email: email,
//  password: password);

// String profileImageUrl = await _uploadProfileImageToStorage(image);

//   await _firestore.collection('admin').doc(cred.user!.uid).set({
// 'email': email,
// 'fullName' : fullName,
// 'phoneNumber' : phoneNumber,
// 'buyerId' :cred.user!.uid,
// 'address':'',
// 'profileImage':profileImageUrl,

//   });
//  res = 'success';

//   }else{
//     res= 'Please fields must not be empty';
//   }
// } catch (e) {
// }
//  return res;
//   }
 

//  loginUsers(String email,String password)async{
//   String res= 'Something went wrong';
//   try {
//     if(email.isNotEmpty && password.isNotEmpty){
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//          password: password );
//          res= 'success';
//     }else{
//       res = 'Please Fields must not be empty ';
//     }
//   } catch (e) {
//     res =e.toString();
//   }
//   return res;
//  }
// }
class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload Profile Image to Firebase Storage
  Future<String> _uploadProfileImageToStorage(Uint8List? image) async {
    try {
      Reference ref =
          _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
      UploadTask uploadTask = ref.putData(image!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading profile image: $e");
      rethrow;
    }
  }

  // Pick Profile Image
  Future<Uint8List?> pickProfileImage(ImageSource source) async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? _file = await _imagePicker.pickImage(source: source);

      if (_file != null) {
        return await _file.readAsBytes();
      } else {
        print("No image selected");
        return null;
      }
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  // Sign Up User
  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password, Uint8List? image) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          image != null) {
        // Create the user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Upload profile image
        String profileImageUrl = await _uploadProfileImageToStorage(image);

        // Save user data to Firestore
        await _firestore.collection('admin').doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user!.uid,
          'address': '',
          'profileImage': profileImageUrl,
        });

        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (e) {
      print("Error during sign up: $e");
      res = e.toString();
    }
    return res;
  }

  // Login User
  Future<String> loginUsers(String email, String password) async {
    String res = 'Something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } catch (e) {
      print("Error during login: $e");
      res = e.toString();
    }
    return res;
  }
}