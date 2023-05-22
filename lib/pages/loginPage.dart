// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/homePage.dart';
import 'package:stock_app/pages/registerPage.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:stock_app/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login_page';

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late DatabaseHelper _databaseHelper;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  void _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text;
    prefs = await SharedPreferences.getInstance();

    if (username.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username or Password Cannot be Empty'),
            backgroundColor: accentColor1,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      User? user = await _databaseHelper.getUserByUsername(username);

      if (user != null && await FlutterBcrypt.verify(password: password, hash: user.password)) {
        await prefs.setString('username', username);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Success'),
              backgroundColor: successColor,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacementNamed(
            context,
            HomePage.routeName,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Failed'),
              backgroundColor: accentColor1,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login Page',
          style: TextStyle(color: accentColor3),
        ),
        automaticallyImplyLeading: false, // hide back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 180,
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  style: const TextStyle(color: primaryColor),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: primaryColor),
                ),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: 100.0,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RegisterPage.routeName,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Don't have an account yet?",
                          style: TextStyle(color: primaryColor)),
                      Text(
                        ' Register',
                        style: TextStyle(
                          color: accentColor1,
                        ),
                      ),
                    ],
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
