import 'package:firebase_tutorial/firebase_service/firebase_authentication.dart';
import 'package:firebase_tutorial/screen/forgeten_password.dart';
import 'package:firebase_tutorial/screen/home_page.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthentication _auth = FirebaseAuthentication();

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    Map<String, dynamic> result;

    if (isLogin) {
      result = await _auth.signIn(email, password);
    } else {
      result = await _auth.signUp(email, password);
    }

    if (result['success']) {
      // Clear fields after successful authentication
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userID: result['uid']),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLogin ? 'Login' : 'Sign Up',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email Field
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white60),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Enter your email';
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+',
                          ).hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Password Field
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        style: const TextStyle(color: Colors.white60),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                () => setState(
                                  () => isPasswordVisible = !isPasswordVisible,
                                ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Enter your password';
                          if (value.length < 6)
                            return 'Password must be at least 6 characters';
                          return null;
                        },
                      ),
                      if (!isLogin)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !isConfirmPasswordVisible,
                            style: const TextStyle(color: Colors.white60),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.deepPurple,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed:
                                    () => setState(
                                      () =>
                                          isConfirmPasswordVisible =
                                              !isConfirmPasswordVisible,
                                    ),
                              ),
                            ),
                            validator: (value) {
                              if (!isLogin &&
                                  value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      if (isLogin)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      // Submit Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          isLogin ? 'Login' : 'Sign Up',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      // Toggle Login/Signup
                      TextButton(
                        onPressed: toggleForm,
                        child: Text(
                          isLogin
                              ? 'Create an Account'
                              : 'Already have an account? Login',
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
