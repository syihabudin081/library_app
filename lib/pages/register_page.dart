import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/db/database_helper.dart';
import 'package:stock_app/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const routeName = '/register_page';
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _passwordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  Future <void> _register() async {
    String name = _nameController.text;
    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Name, Username or Password Cannot be Empty',
          ),
          backgroundColor: accentColor1,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      User? existingUser = await _databaseHelper.getUserByUsername(username);

      if (existingUser != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Username Already Exists!'),
              backgroundColor: accentColor1,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        String hashedPassword = await FlutterBcrypt.hashPw(
            password: password, salt: await FlutterBcrypt.salt());
        User newUser = User(name: name, username: username, password: hashedPassword);
        await _databaseHelper.insertUser(newUser);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register Success'),
              backgroundColor: successColor,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pushReplacementNamed(
            context,
            LoginPage.routeName,
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
          'Register',
          style: TextStyle(color: accentColor3),
        ),
        automaticallyImplyLeading: true, // hide back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 180,
              ),
              const SizedBox(height: 32.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                style: const TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 16.0),
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
                  onPressed: () {
                    _register();
                  },
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(height: 32.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Already have an account ?",
                        style: TextStyle(
                            color: primaryColor)),
                    Text(
                      ' Sign In',
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
    );
  }
}
