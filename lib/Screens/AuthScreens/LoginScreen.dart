import 'dart:convert';

import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/HelperFunctions.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Models/AuthModels/UserModel.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthProvider.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthStates.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../HomeScreens/HomeScreen.dart';
import 'ForgotPassScreen.dart';
import 'SignUpScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تسجيل الدخول"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Image.asset("images/logo.png",width: 180,height: 180,),
                const SizedBox(height: 50,),
                CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
                const SizedBox(height: 15,),
                CustomInput(controller: passwordController, hint: "كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          Navigation.mainNavigator(context, const SignUpScreen());
                        },
                        child: CustomText(text: "تسجيل", fontSize: 16,fontWeight: FontWeight.w600,)),
                    const Spacer(),
                    InkWell(
                        onTap: (){
                          Navigation.mainNavigator(context, const ForgotPassScreen());
                        },
                        child: CustomText(text: "نسيت كلمة المرور ؟", fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 50,),
                Consumer<AuthProvider>(
                    builder: (context, authProvider,child) {
                      return States.registerState==RegisterState.LOADING?const Center(child: CircularProgressIndicator()):CustomButton(text: "دخول",onPressed: () async {
                        String fcm = await getToken();

                        Map<String,dynamic> formData ={
                          "phone": phoneNumberController.text,
                          "password": passwordController.text,
                          "token": fcm,
                          "type": "driver"
                        };
                        UserModel userModel = await authProvider.login(formData);
                        if(userModel.status!){
                          setSavedString("jwt", userModel.data!.apiToken!);
                          setSavedString(
                              "userData", jsonEncode(userModel.data));
                          toast("تم التسجيل بنجاح", context);
                          Position position = await determinePosition();
                          Navigation.removeUntilNavigator(context, HomeScreen());
                        }else{
                          print(userModel.msg);
                          toast(userModel.msg, context);
                        }
                      },);
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
