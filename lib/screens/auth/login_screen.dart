import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';

import '../../presentation/widgets/custom_text_feild.dart';
import '../../services/auth_service/cubit/auth_state.dart';
import '../../services/auth_service/cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

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
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: email.text.trim(),
        password: pass.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoginSuccess) {
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, "/home");
              });
            }
            if (state is AuthFailure) {
              Future.microtask(() {
                Fluttertoast.showToast(
                  msg: state.errors.join('\n'),
                  backgroundColor: Colors.red,
                );
              });
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35),
                        Image.asset(
                          "assets/icons/logo.png",
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 35),

                        CustomTextField(
                          controller: email,
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset("assets/icons/email.svg"),
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
                            child: SvgPicture.asset("assets/icons/pass.svg"),
                          ),
                        ),
                        const SizedBox(height: 15),

                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "/forget-password"),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forget Password ?",
                              style: GoogleFonts.roboto(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: (state is AuthLoading) ? null : _login,
                            child: (state is AuthLoading)
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primary,
                                      ),
                                    ),
                                  )
                                : Text(
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
                            Navigator.pushNamed(context, "/signup");
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don’t Have Account ?",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: " Create One",
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
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.primary,
                                thickness: 1.5,
                                indent: 50,
                              ),
                            ),
                            Text(
                              "  OR  ",
                              style: GoogleFonts.roboto(
                                color: AppColors.primary,
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.primary,
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
                              backgroundColor: AppColors.primary,
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
                            icon: SvgPicture.asset("assets/icons/google.svg"),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Container(
                          width: 135,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
