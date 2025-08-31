import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_colors.dart';

import '../../core/widgets/custom_text_feild.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  List<String> images = [
    "assets/avatar2.png",
    "assets/avatar.png",
    "assets/avatar3.png",
  ];

  int selectedIndex = 1;
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confirmPass;
  late TextEditingController phone;

  bool isSelectedEg = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    username = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confirmPass = TextEditingController();
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    pass.dispose();
    confirmPass.dispose();
    phone.dispose();
    super.dispose();
  }

  // Validators
  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter a username";
    }
    if (value.length < 3) {
      return "Username must be at least 3 characters";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter an email";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }
    if (value != pass.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter phone number";
    }
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "Register",
          style: GoogleFonts.roboto(color: AppColors.amber),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/arrow.svg"),
        ),
        leadingWidth: 38,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.18,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(images.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Image.asset(
                              images[index],
                              width: (index == selectedIndex) ? 105 : 65,
                              height: (index == selectedIndex) ? 105 : 65,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Text(
                  "Avatar",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: username,
                    validator: _validateUsername,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/username.svg"),
                    ),
                    hintText: "Username",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: email,
                    validator: _validateEmail,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/email.svg"),
                    ),
                    hintText: "Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: pass,
                    validator: _validatePassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/pass.svg"),
                    ),
                    hintText: "Password",
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: confirmPass,
                    validator: _validateConfirmPassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/pass.svg"),
                    ),
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: phone,
                    validator: _validatePhone,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/phone.svg"),
                    ),
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _signup,
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.roboto(
                          color: AppColors.background,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already Have Account ? ",
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                        TextSpan(
                          text: " Login",
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
                            child: SvgPicture.asset("assets/eg.svg", width: 45),
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
                            child: SvgPicture.asset("assets/us.svg", width: 45),
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
    );
  }
}
