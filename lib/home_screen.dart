import 'package:flutter/material.dart';
import 'package:post_api/post_api_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _logout () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
        context, MaterialPageRoute(
      builder: (context) => const LoginPage(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title:const Text('HomeScreen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _logout,
              icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to home screen!',
          style: TextStyle(fontSize: 24,color: Colors.blue[800]),),
      ),
    );
  }
}
