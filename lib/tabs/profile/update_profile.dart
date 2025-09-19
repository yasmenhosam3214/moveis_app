import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_colors.dart';
import 'package:moveis_app/core/app_theme.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';
import 'package:moveis_app/core/widgets/custom_text_feild.dart';
import 'package:moveis_app/core/widgets/default_elevatedButton.dart';

import '../../presentation/widgets/custom_text_feild.dart';
import '../../presentation/widgets/default_elevatedButton.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({super.key});
  static const String routeName = 'update-profile';
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController phone;
  static const String routeName = 'update-prfile';
  void initState() {
    phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter phone number";
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Pick Avatar', style: textTheme.titleSmall),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Center(child: Image.asset('assets/avatar1.png')),
              SizedBox(height: 20),
              CustomTextField(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/User-4.svg'),
                ),
                hintText: "John Safwat",
              ),
              SizedBox(height: 15),

              CustomTextField(
                controller: phone,
                validator: _validatePhone,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/phone.svg"),
                ),
                hintText: "01200000000",
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),

              Text(
                'Reset Password',
                style: textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Spacer(),

              DefaultElevatedbutton(
                text: 'Delete Account',
                onPressed: () {},
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.white,
              ),
              SizedBox(height: 20),
              DefaultElevatedbutton(
                onPressed: () {},
                text: 'Update Data',
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
