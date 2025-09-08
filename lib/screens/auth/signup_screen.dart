import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import 'package:moveis_app/services/auth_service/api/auth_service.dart';

import '../../presentation/widgets/custom_text_feild.dart';
import '../../services/auth_service/cubit/auth_state.dart';
import '../../services/auth_service/cubit/user_cubit.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController pass;
  late TextEditingController confirmPass;
  late TextEditingController phone;

  List<int> images = [3, 1, 2];
  int selectedIndex = 1;
  bool isSelectedEg = false;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    pass = TextEditingController();
    confirmPass = TextEditingController();
    phone = TextEditingController();
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

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return "Enter a username";
    if (value.length < 3) return "Username must be at least 3 characters";
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Enter an email";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Enter a password";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Confirm your password";
    if (value != pass.text) return "Passwords do not match";
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Enter phone number";
    final phoneRegex = RegExp(r'^\+20[0-9]{9,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Phone number must start with +20 and contain 9–12 digits";
    }
    return null;
  }

  void _signup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        username: username.text.trim(),
        email: email.text.trim(),
        password: pass.text.trim(),
        confirmPassword: confirmPass.text.trim(),
        phone: phone.text.trim(),
        avatarId: images[selectedIndex],
      );
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
          style: GoogleFonts.roboto(color: AppColors.primary),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset("assets/icons/arrow.svg"),
        ),
        leadingWidth: 38,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Fluttertoast.showToast(
              msg: "Welcome ${state.userResponse.data.name}, please login!",
              backgroundColor: Colors.green,
              textColor: Colors.white
            );
            Navigator.pushNamed(context, "/login");
          } else if (state is AuthFailure) {
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
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
                                  "assets/icons/avatar${images[index]}.png",
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
                          child: SvgPicture.asset("assets/icons/username.svg"),
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
                          child: SvgPicture.asset("assets/icons/email.svg"),
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
                          child: SvgPicture.asset("assets/icons/pass.svg"),
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
                          child: SvgPicture.asset("assets/icons/pass.svg"),
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
                          child: SvgPicture.asset("assets/icons/phone.svg"),
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
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: (state is AuthLoading)
                              ? null
                              : () => _signup(context),
                          child: (state is AuthLoading)
                              ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : Text(
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
                      onTap: () => Navigator.pop(context),
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
                                color: AppColors.primary,
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
                        border: Border.all(color: AppColors.primary, width: 2),
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
                                  color: AppColors.primary,
                                  width: isSelectedEg ? 4 : 0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.background,
                                child: SvgPicture.asset(
                                  "assets/icons/eg.svg",
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
                                  color: AppColors.primary,
                                  width: !isSelectedEg ? 4 : 0,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.background,
                                child: SvgPicture.asset(
                                  "assets/icons/us.svg",
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
            );
          },
        ),
      ),
    );
  }
}
