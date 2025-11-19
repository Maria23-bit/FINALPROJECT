// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/firebase_auth_service.dart';
import 'package:myapp/main.dart'; // Import main for custom colors
import 'package:myapp/screens/welcome_screen.dart'; // Import for navigation
import 'package:myapp/utils/custom_page_route.dart'; // Import for custom page transitions


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _authService.getCurrentUser();
    if (_currentUser == null) {
      // If for some reason the user is null here, redirect to welcome
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToWelcomeScreen();
      });
    }
  }

  void _navigateToWelcomeScreen() {
    Navigator.of(context).pushAndRemoveUntil(
      CustomPageRoute(child: const WelcomeScreen(), direction: SlideDirection.left),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _handleSignOut() async {
    await _authService.signOut();
    _navigateToWelcomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: lightText),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryBlue, secondaryGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  _currentUser?.displayName ?? 'Welcome User!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: lightText),
                ),
                accountEmail: Text(
                  _currentUser?.email ?? 'No email available',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: lightText.withOpacity(0.8)),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: accentGold,
                  foregroundColor: darkText,
                  child: Text(
                    _currentUser?.email != null ? _currentUser!.email![0].toUpperCase() : 'U',
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.8),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: lightText),
                title: Text('Home', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: lightText)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Navigate to home if not already there
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: lightText),
                title: Text('Settings', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: lightText)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // TODO: Navigate to settings screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings functionality coming soon!', style: TextStyle(color: lightText)), backgroundColor: secondaryGreen),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: lightText),
                title: Text('About', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: lightText)),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // TODO: Navigate to about screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('About page under construction!', style: TextStyle(color: lightText)), backgroundColor: secondaryGreen),
                  );
                },
              ),
              Divider(color: lightText.withOpacity(0.6)),
              ListTile(
                leading: const Icon(Icons.logout, color: accentGold),
                title: Text('Sign Out', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: accentGold)),
                onTap: _handleSignOut,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.shade50,
              lightBackground,
              Colors.lightGreen.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline, size: 100, color: secondaryGreen),
                const SizedBox(height: 30),
                Text(
                  'You are successfully logged in!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: primaryBlue),
                ),
                const SizedBox(height: 15),
                Text(
                  'Welcome, ${_currentUser?.email ?? 'User'}!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: darkText.withOpacity(0.8)),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: _handleSignOut,
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: lightText,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: lightText, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Exploring new features!', style: TextStyle(color: lightText)), backgroundColor: primaryBlue),
                    );
                  },
                  icon: const Icon(Icons.explore),
                  label: const Text('Explore More'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBlue,
                    side: const BorderSide(color: primaryBlue, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: primaryBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}