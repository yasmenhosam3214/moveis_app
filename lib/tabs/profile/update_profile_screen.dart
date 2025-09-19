import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/uitls/app_colors.dart';

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
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Pick Avatar",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primary,
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
              SizedBox(height: 30),


              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.gray,
                      shape:  RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding:  EdgeInsets.all(20.0),
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
                                NeverScrollableScrollPhysics(),
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
                                            ? AppColors.primary
                                            : AppColors.gray,
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppColors.primary,
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
                    backgroundColor: AppColors.black,
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: TextFormField(
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "John Safwat",
                    hintStyle:  TextStyle(color: AppColors.white),
                    filled: true,
                    fillColor: AppColors.gray,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/profil.svg",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    contentPadding:  EdgeInsets.symmetric(
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

              SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "01200000000",
                    hintStyle:  TextStyle(color: AppColors.white),
                    filled: true,
                    fillColor: AppColors.gray,
                    prefixIcon: Padding(
                      padding:  EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/phone.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    contentPadding:  EdgeInsets.symmetric(
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

              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: 16),
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

              SizedBox(height: 290),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: TextFormField(
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Delete Account",
                    hintStyle:  TextStyle(color: AppColors.white),
                    filled: true,
                    fillColor: AppColors.red,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 55,
                child: TextFormField(
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Update Data",
                    hintStyle:  TextStyle(color: AppColors.black),
                    filled: true,
                    fillColor: AppColors.primary,
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
