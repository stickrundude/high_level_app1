import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/services/signup_services.dart';
import '/utils/validators.dart';
import '/widgets/background.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  Future<void> signUp(BuildContext context) async {
    final signUpService = SignUpService();

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String firstName = firstNameController.text.trim();
    final String lastName = lastNameController.text.trim();

    if (!Validators.isValidName(firstName)) {
      Fluttertoast.showToast(
          msg: "First Name must only contain letters and cannot be empty.");
      return;
    }

    if (!Validators.isValidName(lastName)) {
      Fluttertoast.showToast(
          msg: "Last Name must only contain letters and cannot be empty.");
      return;
    }

    if (!Validators.isValidEmail(email)) {
      Fluttertoast.showToast(msg: "Please enter a valid email.");
      return;
    }

    if (!Validators.isValidPassword(password)) {
      Fluttertoast.showToast(
          msg:
              "Password should be at least 6 characters and contain both letters and numbers.");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      bool isSuccess = await signUpService.signUpUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      setState(() {
        isLoading = false;
      });

      if (isSuccess) {
        Fluttertoast.showToast(msg: "Sign-up successful! Please log in.");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Sign-up failed. Please try again.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error during sign-up: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 200),
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () => signUp(context),
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text('Sign Up'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
