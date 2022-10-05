import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/HelperFunctions.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Models/AuthModels/UserModel.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthProvider.dart';
import 'package:ebranchdelivery/Providers/Auth/AuthStates.dart';
import 'package:ebranchdelivery/Screens/AuthScreens/LoginScreen.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();

  XFile? file1,file2,file3;
  String images = "";
  GlobalKey _formKey = GlobalKey<FormState>();

  var addressController = TextEditingController();
  @override
  initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تسجيل الدخول"),
      body: Consumer<AuthProvider>(
          builder: (context, AuthProvider authProvider,child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40,),
                      Image.asset("images/logo.png",width: 180,height: 180,),
                      const SizedBox(height: 50,),
                      CustomInput(controller: nameController, hint: "الاسم بالكامل", textInputType: TextInputType.text,suffixIcon: Icon(Icons.person,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      CustomInput(controller: passwordController, hint: "كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      CustomInput(controller: passwordConfirmationController, hint: "تأكيد كلمة المرور", textInputType: TextInputType.text,obscureText: true,suffixIcon: Icon(Icons.lock,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      CustomInput(controller: emailController, hint: "البريد الإلكتروني", textInputType: TextInputType.emailAddress,suffixIcon: Icon(Icons.email,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      CustomInput(controller: phoneNumberController, hint: "رقم الهاتف", textInputType: TextInputType.phone,suffixIcon: Icon(Icons.phone,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      CustomInput(controller: addressController, hint: "العنوان", textInputType: TextInputType.text,suffixIcon: Icon(Icons.home,color: Config.mainColor,),),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                file1 = await _picker.pickImage(source: ImageSource.gallery);
                                if(images=="") {
                                  images = file1!.path;
                                }else{
                                  images = "$images,${file1!.path}";
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Config.mainColor
                                ),
                                child: file1==null?Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.photo),
                                    const SizedBox(height: 7,),
                                    CustomText(text: "صورة الرخصة", fontSize: 11),
                                  ],
                                ):Image.file(File(file1!.path),fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7,),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                file2 = await _picker.pickImage(source: ImageSource.gallery);
                                if(images=="") {
                                  images = file2!.path;
                                }else{
                                  images = "$images,${file2!.path}";
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Config.mainColor
                                ),
                                child: file2==null?Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.photo),
                                    const SizedBox(height: 7,),
                                    CustomText(text: "صورة الاستمارة", fontSize: 11),
                                  ],
                                ):Image.file(File(file2!.path),fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7,),

                          Expanded(
                            child: InkWell(
                              onTap: ()async{
                                final ImagePicker _picker = ImagePicker();
                                file3 = await _picker.pickImage(source: ImageSource.gallery);
                                if(images=="") {
                                  images = file3!.path;
                                }else{
                                  images = "$images,${file3!.path}";
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Config.mainColor
                                ),
                                child: file3==null?Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.photo),
                                    const SizedBox(height: 7,),
                                    CustomText(text: "صورة الاقامة - الهوية", fontSize: 11),
                                  ],
                                ):Image.file(File(file3!.path),fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7,),

                        ],
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 55,
                      //   padding: EdgeInsets.symmetric(horizontal: 10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(13),
                      //     border: Border.all(color: Config.mainColor)
                      //   ),
                      //   alignment: Alignment.centerRight,
                      //   child: Directionality(
                      //     textDirection: TextDirection.rtl,
                      //     child: DropdownButton<countries.Data>(
                      //       value: countriesValue,
                      //       underline: SizedBox(),
                      //       hint: CustomText(text: "اختر الدولة", fontSize: 14),
                      //       onChanged: (countries.Data newValue) async {
                      //         setState(()  {
                      //           countriesValue = newValue;
                      //         });
                      //         citiesValue = null;
                      //         citiesModel = await authProvider.getCities(newValue.id);
                      //       },
                      //       items: countriesModel.data
                      //           .map((countries.Data value) {
                      //         return DropdownMenuItem<countries.Data>(
                      //           value: value,
                      //           child: Container(
                      //             width: Config.responsiveWidth(context)*0.79,
                      //             child: Text(value.name),
                      //           ),
                      //         );
                      //       }).toList(),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 15,),
                      // Consumer<AuthProvider>(
                      //   builder: (context, citiesProvider,child) {
                      //     if(States.citiesState == CitiesState.LOADING){
                      //       return Center(child: CircularProgressIndicator());
                      //     }
                      //
                      //     if(States.citiesState == CitiesState.ERROR){
                      //       return Center(child: CustomText(text: "حدث خطأ", fontSize: 16,fontWeight: FontWeight.w600,));
                      //     }
                      //
                      //     return Container(
                      //       width: double.infinity,
                      //       height: 55,
                      //       padding: EdgeInsets.symmetric(horizontal: 10),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(13),
                      //           border: Border.all(color: Config.mainColor)
                      //       ),
                      //       alignment: Alignment.centerRight,
                      //       child: Directionality(
                      //         textDirection: TextDirection.rtl,
                      //         child: DropdownButton<cities.Data>(
                      //           value: citiesValue,
                      //           icon: citiesModel==null?SizedBox():Icon(Icons.arrow_drop_down),
                      //           underline: SizedBox(),
                      //           hint: CustomText(text: "اختر المدينة", fontSize: 14),
                      //           onChanged: (cities.Data newValue) {
                      //             setState(() {
                      //               citiesValue = newValue;
                      //             });
                      //             print(citiesValue);
                      //           },
                      //           items: citiesModel==null?[]:citiesModel.data
                      //               .map((cities.Data value) {
                      //             return DropdownMenuItem<cities.Data>(
                      //               value: value,
                      //               child: Container(
                      //                 width: Config.responsiveWidth(context)*0.79,
                      //                 child: Text(value.name,textAlign: TextAlign.right,),
                      //               ),
                      //             );
                      //           }).toList(),
                      //         ),
                      //       ),
                      //     );
                      //   }
                      // ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          CustomText(text: "تسجيل", fontSize: 16,fontWeight: FontWeight.w600,),
                          const Spacer(),
                          CustomText(text: "نسيت كلمة المرور ؟", fontSize: 14),
                        ],
                      ),
                      const SizedBox(height: 50,),
                      States.registerState==RegisterState.LOADING?const Center(child: CircularProgressIndicator()):CustomButton(text: "دخول",onPressed: () async {
                        if(passwordController.text!=passwordConfirmationController.text){
                          toast("كلمة المرور غير متطابقة", context);
                          return;
                        }
                        if(file1==null || file2==null || file3==null){
                          toast("من فضلك املاء جميع الصور", context);
                          return;
                        }
                        String fcm = await getToken();

                        Map<String,String> formData = {
                          "name": nameController.text,
                          "email": emailController.text,
                          "phone": phoneNumberController.text,
                          "password": passwordController.text,
                          "address": addressController.text,
                          "type": "driver",
                          "token": fcm,
                        };
                        UserModel userModel = await authProvider.register(formData,file1==null?"":file1!.path,file2==null?"":file2!.path,file3==null?"":file3!.path);
                        if(userModel.status!){
                          setSavedString("jwt", userModel.data!.apiToken!);
                          setSavedString(
                              "userData", jsonEncode(userModel.data));
                          toast("تم التسجيل بنجاح", context);
                          Navigation.mainNavigator(context, const LoginScreen());
                        }else{
                          toast(userModel.msg, context);
                        }
                      },)
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}