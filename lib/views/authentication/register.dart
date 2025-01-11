import 'dart:typed_data';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:multi_vendor_admin/views/authentication/authcontroller.dart';
import 'package:multi_vendor_admin/views/authentication/biometric.dart';
import 'package:multi_vendor_admin/views/authentication/loginscreen.dart';
import 'package:multi_vendor_admin/views/authentication/showsnackbar.dart';
import 'package:multi_vendor_admin/views/screens/main_screen.dart';


class BuyerRegisterScreen extends StatefulWidget {
  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;
  bool _isLoading = false;
  Uint8List? _image;

  //  Future<void> _signUpUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   if (_formKey.currentState!.validate()) {
  //     await _authController.signUpUsers(
  //         email, fullName, phoneNumber, password, _image).whenComplete(() {
  //       setState(() {
  //         _formKey.currentState?.reset();
  //         _isLoading = false;
  //       });

  //       // Ask the user if they want to set up biometric authentication
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Set up Biometric Authentication'),
  //           content: Text('Would you like to set up biometric authentication now?'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => Biometric()),
  //                 );
  //               },
  //               child: Text('Yes'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 // Proceed directly to the main screen if they choose not to set up biometric
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => MainScreen()),
  //                 );
  //               },
  //               child: Text('No'),
  //             ),
  //           ],
  //         ),
  //       );
  //     });

  //     showSnack(context, 'Congratulations! Account has been created');
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showSnack(context, 'Please fill out all fields');
  //   }
  // }


Future<void> _signUpUser() async {
  setState(() {
    _isLoading = true;
  });

  if (_formKey.currentState!.validate()) {
    await _authController
        .signUpUsers(email, fullName, phoneNumber, password, _image)
        .whenComplete(() async {
      setState(() {
        _formKey.currentState?.reset();
        _isLoading = false;
      });

      // Send confirmation email
      await sendConfirmationEmail(email, fullName);

      // Ask the user if they want to set up biometric authentication
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Set up Biometric Authentication'),
          content: Text('Would you like to set up biometric authentication now?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Biometric()),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Proceed directly to the main screen if they choose not to set up biometric
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text('No'),
            ),
          ],
        ),
      );

      showSnack(context, 'Congratulations! Account has been created');
    });
  } else {
    setState(() {
      _isLoading = false;
    });
    showSnack(context, 'Please fill out all fields');
  }
}

Future<void> sendConfirmationEmail(String recipientEmail, String fullName) async {
  final smtpServer = gmail('pujakadayat1@gmail.com', 'your-email-password'); // Replace with your credentials

  final message = Message()
    ..from = Address('your-email@gmail.com', 'Your App Name') // Replace with your email
    ..recipients.add(recipientEmail)
    ..subject = 'Registration Successful'
    ..text = 'Dear $fullName,\n\n'
        'Thank you for registering with us. Your account has been successfully created.\n\n'
        'Best Regards,\nYour App Name Team';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } catch (e) {
    print('Error sending email: $e');
  }
}

  Future<void> selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
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
                            backgroundColor:
                                const Color.fromARGB(255, 13, 62, 86),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Email must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Fullname must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Phone number must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please password must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
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
                      color: const Color.fromARGB(255, 13, 62, 86),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
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
                        }));
                      },
                      child: Text('Login'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
 }