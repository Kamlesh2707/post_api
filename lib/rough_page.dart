import 'package:flutter/material.dart';
import 'package:post_api/Home_Screen.dart';
import 'package:post_api/post_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey <FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hidePassword = true;

  @override
  void initState () {
    super.initState();
    _checkLoginStatus();
  }


  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) =>const  HomeScreen(),
      )
      );
    }
  }

  _saveLoginData(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.purple,
                          offset: Offset(0, 3),
                          blurRadius: 10,
                        )
                      ]),
                  child: Form(
                    key: globalFormKey,
                      child: Column(
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:  (input) =>
                        input != null && input.contains("@") ? null
                            : "Email id should be valid",
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
                            )
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amberAccent,
                            )
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.redAccent,
                          )
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: hidePassword,
                        validator: (input) =>
                        input != null && input.length >= 3 ? null
                            : "Password should be more than 3 characters",
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent,
                            )
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.amberAccent,
                            )
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.redAccent,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(
                                hidePassword ? Icons.visibility_off : Icons.visibility
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (globalFormKey.currentState!.validate()) {
                                bool isAuthenticated = await ApiServices().login(
                                    emailController.text.toString(),
                                    passwordController.text.toString(),
                                );
                                if (isAuthenticated) {
                                  _saveLoginData(
                                      emailController.text.toString(),
                                      passwordController.text.toString(),
                                  );
                                }
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Invalid email or password")),
                                );
                              }
                            },
                            child:const  Text("Login")),
                      )
                    ],
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
