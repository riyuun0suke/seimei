import 'package:flutter/material.dart';
import 'package:SEIMEI/services/auth/auth_service.dart';
import 'package:SEIMEI/components/my_button.dart';
import 'package:SEIMEI/components/my_textfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "There's no account like this or you have bad internet connection. Please try again.",
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A4A),
      body: Center(
        child: isLoading
            ? LoadingAnimationWidget.twistingDots(
                leftDotColor: Color(0xFFE94B35),
                rightDotColor: Color(0xFFBFAF8F), // пастельный нюанс
                size: 60,
              )
            : buildLoginForm(),
      ),
    );
  }

  Widget buildLoginForm() {
    return Stack(
      children: [


        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.3))),

        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo_sun.png', width: 250, height: 250),
                const SizedBox(height: 50),
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(fontSize: 20, color: Color(0xFFD3C9A1)),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  hintText: "example@gmail.com",
                  obscuretext: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  hintText: "Password..",
                  obscuretext: true,
                  controller: _pwController,
                ),
                const SizedBox(height: 25),
                MyButton(text: "Login", onTap: login),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(bottom: 19.0, left: 80.0, right: 80.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1A1A4A),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(
                          0xFFBFAF8F,
                        ), // твой красноватый акцентный цвет
                        width: 1.0, // ширина границы
                      ),
                    ),
                    child: GestureDetector(
                      onTap: widget.onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member? ",
                            style: TextStyle(color: Color(0xFFD3C9A1)),
                          ),

                          Text(
                            "Register",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD3C9A1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
