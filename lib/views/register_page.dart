import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication_controller.dart';
import 'package:forum_app/views/login_page.dart';
import 'package:forum_app/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                "Register",
                style: GoogleFonts.poppins(
                    fontSize: size * 0.080, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'Full Name',
                obsecureText: false,
                controller: _fullNameController,
              ),
              const SizedBox(
                height: 20,
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
                hintText: 'Email',
                obsecureText: false,
                controller: _emailController,
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
              InputWidget(
                hintText: 'Confirmation Password',
                obsecureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.poppins(fontSize: size * 0.040),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: Text(
                      "Login",
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
                            await _authenticationController.register(
                                name: _fullNameController.text.trim(),
                                username: _usernameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                confirmPassword:
                                    _confirmPasswordController.text.trim());
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
