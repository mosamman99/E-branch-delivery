import 'dart:io';

import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/HelperFunctions.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Models/OrderModel.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientPage extends StatefulWidget {
  Data? order;
  ClientPage({Key? key,this.order}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late GoogleMapController googleMapController;

  late HomeProvider reasonProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gvhgvghvgh  ${widget.order!.lat}");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(

            children: [
              const SizedBox(height: 30,),
              Image.asset("images/logo.png",width: 180,height: 180,),
              const SizedBox(height: 30,),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Config.responsiveWidth(context)*0.68,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    child: CustomText(text: widget.order!.driver!.name, fontSize: 14),
                  ),
                  Container(
                    height: 50,
                    width: Config.responsiveWidth(context)*0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: CustomText(text: "الاسم", fontSize: 16,color: Colors.white,),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Config.responsiveWidth(context)*0.68,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    child: CustomText(text: widget.order!.id.toString(), fontSize: 14),
                  ),
                  Container(
                    height: 50,
                    width: Config.responsiveWidth(context)*0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: CustomText(text: "رقم الطلب", fontSize: 16,color: Colors.white,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              CustomButton(text: "اتصال", onPressed: (){
                launch("tel:${widget.order!.products![0].user!.phone}");
              },color: Config.mainColor,),
              const SizedBox(height: 20,),

                   DataTable(
                    border: TableBorder.all(width: 0.5), columns: [
                    DataColumn(label: CustomText(text: "الاسم", fontSize: 16)),
                    DataColumn(label: CustomText(text: "التفاصيل", fontSize: 16)),
                    DataColumn(label: CustomText(text: "الكمية", fontSize: 16)),
                    DataColumn(label: CustomText(text: "السعر", fontSize: 16)),
                  ], rows: List.generate(widget.order!.products!.length, (index) {
                    return DataRow(cells: [
                      DataCell(CustomText(text: widget.order!.products![index].name, fontSize: 13)),
                      DataCell(CustomText(text: widget.order!.products![index].description, fontSize: 13)),
                      DataCell(CustomText(text: widget.order!.amount, fontSize: 13)),
                      DataCell(CustomText(text: "${widget.order!.products![index].price} ر.س", fontSize: 13)),
                    ]);
                  }), // Allows to add a border decoration around your table
                  ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(text: "الاجمالي ${widget.order!.price} ر.س", fontSize: 18),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Config.responsiveWidth(context)*0.68,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    child: CustomText(text: widget.order!.products![0].user!.address, fontSize: 14),
                  ),
                  Container(
                    height: 50,
                    width: Config.responsiveWidth(context)*0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: CustomText(text: "الموقع", fontSize: 16,color: Colors.white,),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 170.0,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      onMapCreated: (controller){
                        googleMapController = controller;
                      },
                      initialCameraPosition: CameraPosition(target: LatLng(double.parse(widget.order!.lat.toString()),double.parse(widget.order!.lang.toString())),zoom: 18),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      // markers: _markers,
                    ),
                    Icon(Icons.add_location,color: Config.mainColor,size: 30,)
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              if(widget.order!.status == "تم الاستلام من المتجر")
                Column(
                  children: [
                    CustomButton(text: "التوجه للعميل", onPressed: (){
                      print("jhbhjbh ${double.parse(widget.order!.driver!.lat.toString())}");
                      GoogleMapInitialize.openMap(double.parse(widget.order!.driver!.lat.toString()), double.parse(widget.order!.driver!.lang.toString()));
                    }),
                    const SizedBox(height: 10,),
                    ChangeNotifierProvider(
                      create: (BuildContext context) => HomeProvider()..getReasons("مرتجع"),
                      child: Selector<HomeProvider,ReasonsState>(
                        selector: (context,provider){
                          reasonProvider = provider;
                          return HomeStates.reasonsState;
                        },
                        builder: (context, state,child) {
                          if(state == ReasonsState.LOADING){
                            return const Center(child: CircularProgressIndicator());
                          }
                          return CustomButton(text: "حدثت مشكلة اثناء التوصيل للعميل", onPressed: () async {
                            await showDialog(context: context,barrierDismissible: true, builder: (context){
                              bool loading = false;
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                title: CustomText(text: "ما سبب عدم توصيل الطلب ؟",textAlign: TextAlign.center,fontWeight: FontWeight.bold, fontSize: 16,),
                                content: StatefulBuilder(
                                    builder: (context, changeState) {
                                      return SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Column(
                                              children: List.generate(reasonProvider.reasonsModel.data!.length, (index) {
                                                return RadioListTile(value: index, groupValue: reasonProvider.radioButtonValue, onChanged: (v){
                                                  reasonProvider.changeValue(v);
                                                  changeState((){});
                                                },title: CustomText(text: reasonProvider.reasonsModel.data![index].name, fontSize: 16),);
                                              }),
                                            ),
                                            CustomButton(text: "ارسال", onPressed: () async {
                                              Map<String,dynamic> formData = {
                                                "orderid": widget.order!.id.toString(),
                                                "status": "back",
                                                "reason": reasonProvider.reasonsModel.data![reasonProvider.radioButtonValue].name
                                              };
                                              loading = true;
                                              changeState((){});
                                              Map<String,dynamic> response = await reasonProvider.changeOrderStatus(formData);
                                              toast(response['msg'], context);
                                              await reasonProvider.getOrders("onproccess");
                                              loading = false;
                                              changeState((){});
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            })
                                          ]
                                        ),
                                      );
                                    }
                                ),
                              );
                            });
                          },);
                        }
                      ),
                    ),
                    const SizedBox(height: 10,),
                    CustomButton(text: "تأكيد التوصيل للعميل", onPressed: () async {
                      var userIdController = TextEditingController();
                      XFile? img;
                      dialog(context, "اكتب كود العميل", [
                        StatefulBuilder(
                          builder: (context, changeState) {
                            return Column(
                              children: [
                                TextField(controller: userIdController,textAlign: TextAlign.center,),
                                const SizedBox(height: 10,),
                                CustomText(text: "ادخل صورة الفاتورة", fontSize: 16),
                                const SizedBox(height: 5,),
                                InkWell(
                                  onTap: () async {
                                    final ImagePicker _picker = ImagePicker();
                                    img = await _picker.pickImage(source: ImageSource.gallery);
                                    changeState((){});
                                  },
                                  child: Container(
                                    height: 80,
                                    width: Config.responsiveWidth(context)*0.88,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Config.buttonColor
                                    ),
                                    alignment: Alignment.center,
                                    child: img==null?const Icon(Icons.camera,size: 50,):Image.file(File(img!.path)),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                CustomButton(text: "ارسال", onPressed: () async {
                                  Map<String,String> formData = {
                                    "orderid": widget.order!.id.toString(),
                                    "userid": userIdController.text
                                  };
                                  if(img==null){
                                    toast("من فضلك ادخل صورة الفاتورة", context);
                                    return;
                                  }
                                  Map<String,dynamic> response = await reasonProvider.finishOrder(formData,img==null?"":img!.path);
                                  toast(response['msg'], context);
                                  if(response['status']) {
                                    await reasonProvider.getOrders("onproccess");
                                    Navigation.removeUntilNavigator(context, HomeScreen(index: 2,));
                                  }
                                })
                              ],
                            );
                          }
                        ),

                      ]);
                    }
                    ),
                  ],
                )
              else if(widget.order!.status == "تم الموافقة من المتجر")
                CustomButton(text: "الموافقة علي الطلب", onPressed: () async {
                  Map<String,dynamic> formData = {
                    "orderid": widget.order!.id.toString(),
                    "status": "accept",
                    "reason": ""
                  };
                  Map<String,dynamic> response = await reasonProvider.changeOrderStatus(formData);
                  toast(response['msg'], context);
                  await reasonProvider.getOrders("online");
                  await reasonProvider.getOrders("onproccess");
                  Navigator.pop(context);
                }),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
