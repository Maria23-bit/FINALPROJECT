// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/firebase_auth_service.dart'; // Corrected import
import 'package:myapp/main.dart'; // Corrected import for custom colors
import 'package:myapp/screens/home_screen.dart'; // Corrected import
import 'package:myapp/utils/custom_page_route.dart'; // Corrected import

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _registerEmailController = TextEditingController();
  final TextEditingController _registerPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoadingLogin = false;
  bool _isLoadingRegister = false;

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightText)),
        backgroundColor: isError ? Colors.red.shade700 : Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      setState(() {
        _isLoadingLogin = true;
      });
      try {
        User? user = await _authService.signInWithEmailAndPassword(
          _loginEmailController.text.trim(),
          _loginPasswordController.text.trim(),
        );
        if (user != null) {
          _showSnackBar('Login Successful! Welcome back.');
          Navigator.of(context).pushAndRemoveUntil(
            CustomPageRoute(child: const HomeScreen(), direction: SlideDirection.right),
            (Route<dynamic> route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Login failed. Please check your credentials.';
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = 'Invalid email or password.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        }
        _showSnackBar(errorMessage, isError: true);
      } finally {
        setState(() {
          _isLoadingLogin = false;
        });
      }
    }
  }

  Future<void> _handleRegister() async {
    if (_registerFormKey.currentState!.validate()) {
      setState(() {
        _isLoadingRegister = true;
      });
      try {
        User? user = await _authService.registerWithEmailAndPassword(
          _registerEmailController.text.trim(),
          _registerPasswordController.text.trim(),
        );
        if (user != null) {
          _showSnackBar('Account created successfully! You are now logged in.');
          Navigator.of(context).pushAndRemoveUntil(
            CustomPageRoute(child: const HomeScreen(), direction: SlideDirection.right),
            (Route<dynamic> route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Registration failed. Please try again.';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'An account already exists for that email.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        }
        _showSnackBar(errorMessage, isError: true);
      } finally {
        setState(() {
          _isLoadingRegister = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: lightText,
          title: Text('My App', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: lightText)),
          centerTitle: true,
          bottom: TabBar(
            labelColor: accentGold,
            unselectedLabelColor: lightText.withOpacity(0.7),
            indicatorColor: accentGold,
            indicatorWeight: 4,
            tabs: const [
              Tab(text: 'Login', icon: Icon(Icons.login)),
              Tab(text: 'Register', icon: Icon(Icons.person_add)),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Placeholder for background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade800,
                    Colors.purple.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            TabBarView(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: kToolbarHeight + 60),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Reconnect & Explore!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Sign in to pick up where you left off and continue your journey towards positive impact.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: darkText.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Icon(Icons.public, size: 80, color: primaryBlue.withOpacity(0.7)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _loginEmailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'your.email@example.com',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),

                            TextFormField(
                              controller: _loginPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 50),

                            _isLoadingLogin
                                ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryBlue)))
                                : ElevatedButton(
                                    onPressed: _handleLogin,
                                    child: const Text('Login'),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: kToolbarHeight + 60),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Join Our Community!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: secondaryGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Create an account and unlock a world of sustainable choices, exclusive content, and meaningful connections.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: darkText.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Icon(Icons.people_alt, size: 80, color: secondaryGreen.withOpacity(0.7)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      Form(
                        key: _registerFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _registerEmailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'new.user@example.com',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),

                            TextFormField(
                              controller: _registerPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Create a strong password',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),

                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                hintText: 'Re-enter your password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _registerPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 50),

                            _isLoadingRegister
                                ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(secondaryGreen)))
                                : ElevatedButton(
                                    onPressed: _handleRegister,
                                    style: ElevatedButton.styleFrom(backgroundColor: secondaryGreen),
                                    child: const Text('Register'),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}