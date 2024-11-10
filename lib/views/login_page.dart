import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication_controller.dart';
import 'package:forum_app/views/register_page.dart';
import 'package:forum_app/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: GoogleFonts.poppins(
                    fontSize: size * 0.080, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Username',
                obsecureText: false,
                controller: _usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password',
                obsecureText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.poppins(fontSize: size * 0.040),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                        fontSize: size * 0.040,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const LinearProgressIndicator(
                          color: Colors.black,
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          onPressed: () async {
                            await _authenticationController.login(
                              username: _usernameController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                                fontSize: size * 0.040, color: Colors.white),
                          ));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
