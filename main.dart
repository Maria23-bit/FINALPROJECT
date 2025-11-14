import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/send_money_screen.dart';

void main() {
  runApp(const EthosploreApp());
}

class EthosploreApp extends StatelessWidget {
  const EthosploreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ethosplore',
      theme: ThemeData(
        primaryColor: const Color(0xFF3498DB),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF3498DB),
          secondary: Color(0xFF2980B9),
          background: Colors.white,
        ),
        splashColor: const Color(0xFFE0F2F7),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/send-money': (context) => const SendMoneyScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/dashboard':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const DashboardScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
            );
          case '/send-money':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SendMoneyScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            );
        }
      },
    );
  }
}