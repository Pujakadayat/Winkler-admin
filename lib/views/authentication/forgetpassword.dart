import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static TextEditingController emailController = TextEditingController();
  bool isResettingPassword = false;

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   super.dispose();
  // }

 Future<void> passwordReset() async {
  if (!mounted) {
    return; // Check if the widget is still mounted
  }

  if (isResettingPassword) {
    return; // Don't allow multiple password reset attempts
  }

  try {
    setState(() {
      isResettingPassword = true;
    });

    String email = emailController.text.trim(); // Store the email locally

    // Check if the widget is still mounted before using emailController
    if (!mounted) {
      return;
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text("Password reset link sent. Check your email."),
        );
      },
    );
  } on FirebaseAuthException catch (e) {
    print(e);

    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Error: ${e.message}"),
        );
      },
    );
  } finally {
    if (mounted) {
      setState(() {
        isResettingPassword = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("Enter your email, and we will send you a password reset link."),
          ),
          const SizedBox(height: 10),
          // Email textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: isResettingPassword ? null : passwordReset,
            color: Colors.deepPurple[200],
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }
}