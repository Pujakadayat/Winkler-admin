import 'dart:typed_data';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:multi_vendor_admin/views/authentication/authcontroller.dart';

import 'package:multi_vendor_admin/views/authentication/loginscreen.dart';
import 'package:multi_vendor_admin/views/authentication/showsnackbar.dart';
import 'package:multi_vendor_admin/views/screens/main_screen.dart';




class AdminRegisterScreen extends StatefulWidget {
  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;
  bool _isLoading = false;
  Uint8List? _image;
Future<void> _signUpUser() async {
  setState(() {
    _isLoading = true;
  });

  if (_formKey.currentState!.validate()) {
    String result = await _authController
        .signUpUsers(email, fullName, phoneNumber, password, _image);
    setState(() {
      _isLoading = false;
    });

    if (result == 'success') {
      // Navigate to the main screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));

      // // Optional: Show success message
      // showSnack(context, 'Congratulations! Account has been created');
    } else {
      // Registration failed, show error message
      showSnack(context, result);
    }
  } else {
    setState(() {
      _isLoading = false;
    });
    showSnack(context, 'Please fill out all fields');
  }
}

  // Future<void> _signUpUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   if (_formKey.currentState!.validate()) {
  //     String result = await _authController
  //         .signUpUsers(email, fullName, phoneNumber, password, _image);
  //     setState(() {
  //       _isLoading = false;
  //     });

  //     if (result == 'success') {
  //          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));

  //       showSnack(context, 'Congratulations! Account has been created');
  //     } else {
  //       // Registration failed
  //       showSnack(context, result);
  //     }
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showSnack(context, 'Please fill out all fields');
  //   }
  // }

  Future<void> selectGalleryImage() async {
    Uint8List? im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create Admin Account",
                  style: TextStyle(fontSize: 20),
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.grey,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.grey[500],
                            backgroundImage: NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                          ),
                    Positioned(
                      right: 0,
                      top: 5,
                      child: IconButton(
                        onPressed: selectGalleryImage,
                        icon: Icon(CupertinoIcons.photo),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Email must not be empty' : null,
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Full Name must not be empty' : null,
                    onChanged: (value) => fullName = value,
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) => value!.isEmpty
                        ? 'Phone Number must not be empty'
                        : null,
                    onChanged: (value) => phoneNumber = value,
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Password must not be empty' : null,
                    onChanged: (value) => password = value,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _signUpUser,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                    ),
                  ),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }
                        )
                        );
                      },
                      child: Text('Login'),
                    ),
              ],
            ),
          ]
          ),
        ),
      ),
    ));
  }

  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
