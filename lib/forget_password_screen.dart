import 'package:flutter/material.dart';
import 'package:moveis_app/app_theme.dart';
import 'package:moveis_app/widgets/default_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName ='/forget password';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back,
            color: AppTheme.primary),
    onPressed: () => Navigator.pop(context),
    ),
          title: Text(
            "Forget Password",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
    ),
      body: Column(
        children: [

          Padding(
            padding:  EdgeInsets.only( top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,

                ),
                Center(

                  child:
                  Image.asset('assets/images/forget_password.png' ,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain
                  ),
                ),
                SizedBox(height: 50,),
                DefaultTextFormField(

                  hintText: "Email",
                  controller:emailController ,
                  prefixIconImageName: 'email',


                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                ),


                    onPressed: () {},
                    child: Text(
                      'Verify Email',
                      style:
                      Theme.of(context).textTheme.bodyMedium?.copyWith (
                    color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ),


              ],
            ),
          ),
        ],
      ),

    );
  }
}
