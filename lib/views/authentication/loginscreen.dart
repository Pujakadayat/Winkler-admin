
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:multi_vendor_admin/views/authentication/authcontroller.dart';
import 'package:multi_vendor_admin/views/authentication/forgetpassword.dart';
import 'package:multi_vendor_admin/views/authentication/register.dart';
import 'package:multi_vendor_admin/views/authentication/showsnackbar.dart';
import 'package:multi_vendor_admin/views/screens/main_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false;
  late final LocalAuthentication _localAuthentication;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _localAuthentication = LocalAuthentication();
    _checkBiometricAvailability();
  }

  // Check if the device supports biometric authentication
  Future<void> _checkBiometricAvailability() async {
    bool canAuthenticate = await _localAuthentication.canAuthenticate();
    setState(() {
      _isBiometricAvailable = canAuthenticate;
    });
  }

  // Attempt to authenticate using biometric authentication
  Future<void> _authenticateWithBiometrics() async {
    try {
      bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: "Please authenticate to log in",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (isAuthenticated) {
        print('Authentication Successful!');
        // Navigate to the MainScreen if authentication is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        print('Authentication Failed');
        showSnack(context, 'Fingerprint authentication failed.');
      }
    } on PlatformException catch (e) {
      print("Error during authentication: $e");
      showSnack(context, 'An error occurred during biometric authentication.');
    }
  }

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = (await _authController.loginUsers(email, password)) as String;

      if (res == 'success') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }));
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnack(context, res);
      }
    } else {
      return showSnack(context, 'Please fill in all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login  to Admin Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    email = value;
                  }),
                  decoration: InputDecoration(
                    labelText: 'Enter Email Address',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    password = value;
                  }),
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (_isBiometricAvailable)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _authenticateWithBiometrics,
                    child: const Text(
                      'Login with Fingerprint',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _loginUsers,
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 13, 62, 86),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              letterSpacing: 5,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Need An Account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: ((context) {
                        return BuyerRegisterScreen();
                      })));
                    },
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on LocalAuthentication {
  canAuthenticate() {}
}
