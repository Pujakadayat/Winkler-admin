import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:multi_vendor_admin/views/screens/main_screen.dart';

class Biometric extends StatefulWidget {
  const Biometric({super.key});

  @override
  State<Biometric> createState() => _BiometricState();
}

class _BiometricState extends State<Biometric> {
  late final LocalAuthentication myauthentication;
  bool authState= false;
void initState(){
  super.initState();
  myauthentication = LocalAuthentication();
  myauthentication.isDeviceSupported().then(
    (bool myAuth) => setState(() {
      authState = myAuth;
    })
  );
}
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("SetUp Authentication"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: authentication,
               child: const Text(
                "Authentication",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
               ))
          ],
        ),
      ),
    );
  }
  Future <void> authentication() async{
    try{
      bool isAuthenticate= await  myauthentication.authenticate(
        localizedReason: "local authentication",
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
        );
        if (isAuthenticate) {
        print('Authentication Successful!');
        // Navigate to the MainScreen if authentication is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        print('Authentication Failed');
      }}

        // print('Authentication Status: $isAuthenticate');
    on PlatformException catch  (e){
      print(e);
    }
  }
}