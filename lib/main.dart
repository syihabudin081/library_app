import 'package:flutter/material.dart';
import 'package:stock_app/pages/login_page.dart';
import 'package:stock_app/pages/profile_page.dart';
import 'package:stock_app/pages/register_page.dart';
import 'package:stock_app/pages/home_page.dart';
import 'package:stock_app/common/styles.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        RegisterPage.routeName: (_) => const RegisterPage(),
        HomePage.routeName: (_) => const HomePage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
      },
    );
    }
  }
