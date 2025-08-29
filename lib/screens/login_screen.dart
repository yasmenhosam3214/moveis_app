import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_colors.dart';
import 'package:moveis_app/screens/signup_screen.dart';
import 'package:moveis_app/widgets/custom_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController pass;
  bool isSelectedEg = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    pass = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    // Simple email regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    Image.asset("assets/logo.png", width: 120, height: 120),
                    const SizedBox(height: 35),
                    CustomTextField(
                      controller: email,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/email.svg"),
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      controller: pass,
                      hintText: "Password",
                      obscureText: true,
                      validator: _validatePassword,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/pass.svg"),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password ?",
                        style: GoogleFonts.roboto(color: AppColors.amber),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _login,
                        child: Text(
                          "Login",
                          style: GoogleFonts.roboto(
                            color: AppColors.background,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don’t Have Account ?",
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                            TextSpan(
                              text: " Create One",
                              style: GoogleFonts.roboto(
                                color: AppColors.amber,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.amber,
                            thickness: 1.5,
                            indent: 50,
                          ),
                        ),
                        Text(
                          "  OR  ",
                          style: GoogleFonts.roboto(color: AppColors.amber),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.amber,
                            thickness: 1.5,
                            endIndent: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {},
                        label: Text(
                          "Login With Google",
                          style: GoogleFonts.roboto(
                            color: AppColors.background,
                            fontSize: 16,
                          ),
                        ),
                        icon: SvgPicture.asset("assets/google.svg"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 135,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.amber, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.amber,
                                  width: isSelectedEg ? 4 : 0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.background,
                                child: SvgPicture.asset(
                                  "assets/eg.svg",
                                  width: 45,
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                isSelectedEg = true;
                              });
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.amber,
                                  width: !isSelectedEg ? 4 : 0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.background,
                                child: SvgPicture.asset(
                                  "assets/us.svg",
                                  width: 45,
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                isSelectedEg = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
