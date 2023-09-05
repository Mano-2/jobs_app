import 'package:flutter/material.dart';
import 'package:login_rest_api/authentication/auth_screen.dart';
import 'package:login_rest_api/services/authentication_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateToLogin() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            // Handle the selected item here

            if (value == 'logout') {
              final logoutValue = await AuthService().logout();
              if (logoutValue == true) {
                navigateToLogin();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 3),
                    content:
                        Text('error with your token, have to login again')));
                navigateToLogin();
              }
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout),
                  Text('Logout'),
                ],
              ),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ],
    ));
  }
}
