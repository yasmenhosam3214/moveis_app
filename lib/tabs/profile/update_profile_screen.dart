import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moveis_app/presentation/widgets/custom_text_feild.dart';
import 'package:moveis_app/presentation/widgets/default_elevatedButton.dart';
import 'package:moveis_app/services/auth_service/cubit/user_cubit.dart';
import '../../core/uitls/app_colors.dart';
import '../../services/auth_service/cubit/auth_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = "/update";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int? selectedIndex;
  String profileImage = "assets/images/avatar_1.png";
  bool showPasswordFields = false;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController oldPassController;
  late TextEditingController newPassController;

  static const double fieldSpacing = 20.0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    oldPassController = TextEditingController();
    newPassController = TextEditingController();

    context.read<AuthCubit>().getProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    oldPassController.dispose();
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Update Profile",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ProfileUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PassChanged) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response),
                  backgroundColor: Colors.green,
                ),
              );
              oldPassController.clear();
              newPassController.clear();
              setState(() => showPasswordFields = false);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errors.join(", ")),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is PassFailedChanged) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.response),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileFetched) {
              final profile = state.profile;
              if (nameController.text.isEmpty) {
                nameController.text = profile.name;
                phoneController.text = profile.phone;
                selectedIndex = profile.avaterId ?? 1;
                profileImage = "assets/images/avatar_${selectedIndex}.png";
              }
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  buildAvatarPicker(),
                  const SizedBox(height: fieldSpacing),
                  CustomTextField(
                    controller: nameController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/icons/profil.svg"),
                    ),
                    labelText: "Name",
                  ),
                  const SizedBox(height: fieldSpacing),
                  CustomTextField(
                    controller: phoneController,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/icons/phone.svg"),
                    ),
                    labelText: "Phone",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: fieldSpacing),
                  buildPasswordToggle(),
                  if (showPasswordFields) buildPasswordFields(),
                  const SizedBox(height: fieldSpacing),
                  buildDeleteAccountButton(),
                  const SizedBox(height: 20),
                  buildUpdateProfileButton(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildAvatarPicker() {
    return Center(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.gray,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(9, (index) {
                  final avatarPath = "assets/images/avatar_${index + 1}.png";
                  final isSelected = selectedIndex == index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index + 1;
                        profileImage = avatarPath;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.gray,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.white : AppColors.gray,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(avatarPath, fit: BoxFit.contain),
                    ),
                  );
                }),
              ),
            ),
          );
        },
        child: CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.black,
          backgroundImage: AssetImage(profileImage),
        ),
      ),
    );
  }

  Widget buildPasswordToggle() {
    return GestureDetector(
      onTap: () => setState(() => showPasswordFields = !showPasswordFields),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget buildPasswordFields() {
    return Column(
      children: [
        const SizedBox(height: 15),
        CustomTextField(
          hintText: "Old Password",
          obscureText: true,
          controller: oldPassController,
        ),
        const SizedBox(height: 15),
        CustomTextField(
          hintText: "New Password",
          obscureText: true,
          controller: newPassController,
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) => DefaultElevatedbutton(
              onPressed: state is AuthLoading
                  ? null
                  : () {
                      context.read<AuthCubit>().resetPass(
                        oldPass: oldPassController.text,
                        newPass: newPassController.text,
                      );
                    },
              backgroundColor: AppColors.primary,
              text: state is AuthLoading ? "Changing..." : "Change Password",
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDeleteAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: DefaultElevatedbutton(
        onPressed: () {},
        backgroundColor: AppColors.red,
        text: "Delete Account",
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget buildUpdateProfileButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) => DefaultElevatedbutton(
          onPressed: state is AuthLoading
              ? null
              : () {
                  final avatarId = selectedIndex ?? 1;
                  context.read<AuthCubit>().updateProfile(
                    name: nameController.text,
                    phone: phoneController.text,
                    avaterId: avatarId,
                  );
                  print(avatarId);
                },
          backgroundColor: AppColors.primary,
          text: state is AuthLoading ? "Updating..." : "Update Data",
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
