import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/HelperFunctions.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthProvider.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthStates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "استعادة كلمة المرور"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Image.asset("images/logo.png",width: 180,height: 180,),
              const SizedBox(height: 50,),
              CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
              const SizedBox(height: 15,),
              CustomInput(controller: passwordController, hint: "كلمة المرور الجديدة", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
              const SizedBox(height: 50,),
              Consumer<AuthProvider>(
                  builder: (context, authProvider,child) {
                    return States.registerState==RegisterState.LOADING?const Center(child: CircularProgressIndicator()):CustomButton(text: "ارسال",onPressed: () async {
                      if(passwordController.text.isEmpty || passwordController.text.isEmpty){
                        toast("من فضلك املأ جميع البيانات", context);
                        return;
                      }
                      Map<String,dynamic> formData ={
                        "phone": phoneNumberController.text,
                        "newpassword": passwordController.text,
                        "type": "driver"
                      };
                      Map<String,dynamic> userModel = await authProvider.forgotPass(formData);
                      toast(userModel['msg'], context);
                      if(userModel['status']){
                        Navigator.pop(context);
                      }

                    },);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
