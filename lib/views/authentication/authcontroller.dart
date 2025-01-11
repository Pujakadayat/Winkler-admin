import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController{
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

_uploadProfileImageToStorage(Uint8List? image)async{

 Reference ref =
 
 _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
 UploadTask uploadTask = ref.putData(image!);

 TaskSnapshot snapshot = await  uploadTask;
 String downloadUrl = await snapshot.ref.getDownloadURL();

 return downloadUrl;
}

pickProfileImage(ImageSource source)async{
  final ImagePicker _imagePicker = ImagePicker();

XFile? _file = await  _imagePicker.pickImage(source: source);
{

}
if(_file!=null){
  return await _file.readAsBytes();
}else{
  print("No image selected");
}

}

  Future<String> signUpUsers(String email,String fullName, String phoneNumber,
   String password, Uint8List? image) async{

String res = 'Some error occured';

try {
  if(email.isNotEmpty && fullName.isNotEmpty && password.isNotEmpty && phoneNumber.isNotEmpty && image !=null ){
    //create the users
UserCredential cred= await _auth.createUserWithEmailAndPassword(
  email: email,
 password: password);

String profileImageUrl = await _uploadProfileImageToStorage(image);

  await _firestore.collection('buyers').doc(cred.user!.uid).set({
'email': email,
'fullName' : fullName,
'phoneNumber' : phoneNumber,
'buyerId' :cred.user!.uid,
'address':'',
'profileImage':profileImageUrl,

  });
 res = 'success';

  }else{
    res= 'Please fields must not be empty';
  }
} catch (e) {
}
 return res;
  }
 

 loginUsers(String email,String password)async{
  String res= 'Something went wrong';
  try {
    if(email.isNotEmpty && password.isNotEmpty){
      await _auth.signInWithEmailAndPassword(
        email: email,
         password: password );
         res= 'success';
    }else{
      res = 'Please Fields must not be empty ';
    }
  } catch (e) {
    res =e.toString();
  }
  return res;
 }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';


// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   late Rx<User?> _user;
//   User get user => _user.value!;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // @override
//   // void onReady() {
//   //   super.onReady();
//   //   _user = Rx<User?>(FirebaseAuth.instance.currentUser);
//   //   _user.bindStream(FirebaseAuth.instance.authStateChanges());
//   //   ever(_user, _setInitialScreen);
//   // }

//   // _setInitialScreen(User? user) {
//   //   if (user == null) {
//   //     Get.off(() => LoginScreen());
//   //   } else {
//   //     Get.off(() => MainScreen());
//   //   }
//   // }

//   // pickProfileImage(ImageSource source) async {
//   //   final ImagePicker _imagePicker = ImagePicker();

//   //   XFile? _file = await _imagePicker.pickImage(source: source);

//   //   if (_file != null) {
//   //     return await _file.readAsBytes();
//   //   } else {
//   //     print('No Image Selected or Captured');
//   //   }
//   // }

//   ///FUNCTION TO UPLOAD IMAGE TO FIREBASE STOREAGE

//   // _uploadImageToStorage(Uint8List? image) async {
//   //   Reference ref =
//   //       _storage.ref().child('profileImages').child(_auth.currentUser!.uid);
//   //   UploadTask uploadTask = ref.putData(image!);

//   //   TaskSnapshot snapshot = await uploadTask;

//   //   String downloadUrl = await snapshot.ref.getDownloadURL();

//   //   return downloadUrl;
//   // }

//   Future<String> createNewUser(
//     String email,
//     String fullName,
//     String password,
//   ) async {
//     String res = 'some erorr occured';

//     try {
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       // String downloadUrl = await _uploadImageToStorage(image);

//       await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
//         'fullName': fullName,
//         'profileImage': '',
//         'email': email,
//         'uid': userCredential.user!.uid,
//         'pinCode ': "",
//         'locality': "",
//         'city': '',
//         'state': '',
//       });

//       res = 'success';
//     } catch (e) {
//       res = e.toString();
//     }

//     return res;
//   }

//   ///FUNCTION TO LOGIN THE CREATED USER
// Future<Map<String, dynamic>> loginUser(String email, String password) async {
//   Map<String, dynamic> res = {'status': 'error', 'role': ''};

//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     DocumentSnapshot userDoc = await _firestore
//         .collection('buyers') // Assuming buyers are stored in a 'buyers' collection
//         .doc(userCredential.user!.uid)
//         .get();

//     if (userDoc.exists) {
//       res = {
//         'status': 'success',
//         'role': 'buyer', // Set the role as 'buyer' for buyers
//       };
//     } else {
//       res['status'] = 'Invalid user role or user not found.';
//     }
//   } catch (e) {
//     res['status'] = e.toString();
//   }

//   return res;
// }


// }