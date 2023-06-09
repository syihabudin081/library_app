import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/login_page.dart';
import 'package:stock_app/db/database_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const routeName = '/profile_page';
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  bool isEditing = false;

  late DatabaseHelper _databaseHelper;
  late User? user;
  late SharedPreferences prefs;
  String name = '';

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    loadProfileData();
  }

  Future <void> loadProfileData() async {
    prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    user = await _databaseHelper.getUserByUsername(username!);
    if (mounted) {
      setState(() {
        name = user!.name;
        String? imagePath = prefs.getString('profileImagePath');
        if (imagePath != null && imagePath.isNotEmpty) {
          image = XFile(imagePath);
        }
      });
    }
  }

  Future <void> saveProfileData() async {
    if (mounted) {
      if (image != null) {
        await prefs.setString('profileImagePath', image!.path);
      } else {
        await prefs.remove('profileImagePath');
      }
    }
  }

  Future <void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (mounted) {
      setState(() {
        image = img;
      });
    }
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: accentColor3),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (isEditing) {
                  myAlert();
                }
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                  image: image != null
                      ? DecorationImage(
                          image: FileImage(File(image!.path)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: isEditing
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Hi, $name',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (mounted) {
                  if (isEditing) {
                    saveProfileData;
                  }
                  toggleEdit();
                }
              },
              child: Text(isEditing ? 'Save' : 'Edit'),
            ),
            const SizedBox(height: 64.0),
            ElevatedButton(
              onPressed: () async {
                await prefs.remove('username');
                if (mounted) {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor1,
              ),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
