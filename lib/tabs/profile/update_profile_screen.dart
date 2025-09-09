import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moveis_app/core/app_theme.dart';

import '../../core/uitls/app_theme.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "/update";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int? selectedIndex;
  String profileImage = "assets/images/avatar_1.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        backgroundColor: AppTheme.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pick Avatar",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),


              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppTheme.gray,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),

                              // Grid of Avatars
                              GridView.count(
                                crossAxisCount: 3,
                                shrinkWrap: true,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                children: List.generate(9, (index) {
                                  bool isSelected = selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        profileImage =
                                        "assets/images/avatar_${index + 1}.png";
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppTheme.primary
                                            : AppTheme.gray,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppTheme.primary,
                                          width: 2,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset(
                                        "assets/images/avatar_${index + 1}.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.black,
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: TextFormField(
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppTheme.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "John Safwat",
                    hintStyle: const TextStyle(color: AppTheme.white),
                    filled: true,
                    fillColor: AppTheme.gray,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/profil.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppTheme.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "01200000000",
                    hintStyle: const TextStyle(color: AppTheme.white),
                    filled: true,
                    fillColor: AppTheme.gray,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/phone.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Reset Password",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 290),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: TextFormField(
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppTheme.white,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Delete Account",
                    hintStyle: const TextStyle(color: AppTheme.white),
                    filled: true,
                    fillColor: AppTheme.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: TextFormField(
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppTheme.black,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Update Data",
                    hintStyle: const TextStyle(color: AppTheme.black),
                    filled: true,
                    fillColor: AppTheme.primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
