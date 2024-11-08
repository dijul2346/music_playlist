import 'package:flutter/material.dart';
import 'package:music_playlist/domain/database.dart';
import 'package:music_playlist/domain/user_model.dart';
import 'package:music_playlist/presentation/login_screen.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup here',
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name Cannot be empty!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email Cannot be empty!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Cannot be empty!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Cannot be empty!';
                    } else if (confirmPasswordController.text !=
                        passwordController.text) {
                      return 'Password Mismatch!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number Cannot be empty!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: TextFormField(
                  controller: addressController,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address Cannot be empty!';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Address',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
              Padding(
  padding: const EdgeInsets.only(top: 20),
  child: ElevatedButton(
    onPressed: () async {
      if (_formKey.currentState!.validate()) {
        UserModel user = UserModel(
          userAddress: addressController.text,
          userName: nameController.text,
          userEmail: emailController.text,
          userPassword: passwordController.text,
          userMobile: mobileController.text,
          userId: '1',
        );

        try {
          // Attempt to register the user
          await registerUser(user);

          // Show success message
          final successSnackBar = SnackBar(
            content: const Text('Registration successful!'),
            action: SnackBarAction(
              label: 'Go to Login',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ScreenLogin()),
                );
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
        } catch (e) {
          // Show failure message if an error occurs
          final failureSnackBar = SnackBar(
            content: Text('Registration failed: $e'),
            action: SnackBarAction(
              label: 'Try Again',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(failureSnackBar);
        }
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple, // Purple background
      minimumSize: Size(MediaQuery.of(context).size.width * .7, 50), // Button width
    ),
    child: const Text(
      'Register',
      style: TextStyle(color: Colors.white, fontSize: 22), // White text
    ),
  ),
)
,
            ],
          ),
        ),
      ),
    );
  }
}
