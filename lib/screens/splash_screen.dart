import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:login_rest_api/authentication/auth_screen.dart';
import 'package:login_rest_api/models/config.dart';
import 'package:login_rest_api/screens/home_screen.dart';
import 'package:login_rest_api/services/authentication_service.dart';
import 'package:login_rest_api/services/http_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _setup(context).then((_) {
      Future.delayed(const Duration(seconds: 1), () async {
        final user = await AuthService().getUser();
        // ignore: avoid_print
        print(user?.email);
        if (user == null) {
          navigateToLogin();
        } else {
          navigateToHome();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.PNG'),
                fit: BoxFit.contain)),
      ),
    );
  }
}

Future<void> _setup(BuildContext context) async {
  final getIt = GetIt.instance;

  final configFile = await rootBundle.loadString('assets/config/main.json');
  final configData = jsonDecode(configFile);

  getIt.registerSingleton<AppConfig>(
      AppConfig(baseApiUrl: configData['BASE_API_URL']));

  getIt.registerSingleton<HTTPService>(
    HTTPService(),
  );
  //   getIt.registerSingleton<JobService>(
  //   JobService(),
  // );
}
