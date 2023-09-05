import 'package:flutter/material.dart';
import 'package:login_rest_api/models/user.dart';
import 'package:login_rest_api/screens/home_screen.dart';
import 'package:login_rest_api/services/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _emailController = TextEditingController(text: 'manar@hot.com');
  final _usernameController = TextEditingController(text: 'manar');
  final _passwordController = TextEditingController(text: 'sohot123');
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        UserModel? user = await _auth.signUp(
                            _emailController.text,
                            _usernameController.text,
                            _passwordController.text);
                        if (user != null) {
                          _navigateToHome();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text('Email or password incorrect')));
                        return;
                      }
                    },
                    child: const Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
