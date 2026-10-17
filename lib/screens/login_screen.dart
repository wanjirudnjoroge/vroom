import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vroom/view_model/auth_view.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  String _message = '';
  bool _isSuccess = false;
  bool _hideUsername = true;
  bool _hidePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Logo
                    Image.asset(
                      'assets/images/deer_logo.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 24),

                    // Welcome text
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Please Login to Continue',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Success/Error message
                    if (_message.isNotEmpty) ...[
                      Text(
                        _message,
                        style: TextStyle(
                          color: _isSuccess
                              ? Colors.green
                              : Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Username field
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: _hideUsername,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hideUsername
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _hideUsername = !_hideUsername;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your username';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthView>(
                        builder: (context, authView, child) {
                          return ElevatedButton(
                            onPressed: authView.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      final bool success =
                                          await authView.login(
                                        _usernameController.text.trim(),
                                        _passwordController.text,
                                      );

                                      if (success) {
                                        setState(() {
                                          _isSuccess = true;
                                          _message = 'Login Successful';
                                        });

                                        if (context.mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen(),
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _isSuccess = false;
                                          _message =
                                              authView.errorMessage ??
                                                  'Login Failed';
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _message = '';
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: authView.isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Signup navigation
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Not yet registered? ',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'signup here',
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}