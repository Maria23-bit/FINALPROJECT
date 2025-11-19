// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/utils/custom_page_route.dart'; // Ensure this matches your project name
import 'package:myapp/screens/send_money_screen.dart'; // Ensure this matches your project name
import 'package:myapp/main.dart'; // Import main.dart for color constants

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App Login'), // App Name in title
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: primaryBlue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sign in to discover your next ethical adventure.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: darkText.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 50),

              // Username TextField
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'e.g., ethical_explorer',
                  prefixIcon: Icon(Icons.person_outline), // Icons styled via InputDecorationTheme
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 25),

              // Password TextField
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your secure password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 50),

              // Login and Registration Buttons side by side using Row
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('Login Button Clicked!');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Attempting Login...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightText)),
                            backgroundColor: primaryBlue,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                        // Navigate to SendMoneyScreen with custom transition
                        Navigator.of(context).pushReplacement(
                          CustomPageRoute(
                            child: const SendMoneyScreen(),
                            direction: SlideDirection.right,
                          ),
                        );
                      },
                      child: const Text('Login'), // Text styled via ElevatedButtonTheme
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        print('Register Button Clicked!');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Redirecting to Registration...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightText)),
                            backgroundColor: secondaryGreen, // Use secondary green for feedback
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      child: const Text('Register'), // Text styled via OutlinedButtonTheme
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}