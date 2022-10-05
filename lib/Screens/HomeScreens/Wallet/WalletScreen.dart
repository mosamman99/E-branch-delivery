import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ChargeWalletScreen.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  HomeProvider? homeProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "الرصيد"),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..getWallet(),
        child: Selector<HomeProvider,ReasonsState>(
          selector: (context,provider){
            homeProvider = provider;
            return HomeStates.reasonsState;
          },
          builder: (context, state,child) {
            if(state == ReasonsState.LOADING){
              return const Center(child: CircularProgressIndicator());
            }
            if(state == ReasonsState.ERROR){
              return Center(child: CustomText(text: "حدث خطأ", fontSize: 16),);
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("images/logo.png",width: 180,height: 180,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 50,
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: CustomText(text: homeProvider!.walletModel!.wallet.toString(), fontSize: 16),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all()),
                        ),
                        CustomText(text: "رصيدك هو : ", fontSize: 16),
                      ],
                    ),
                    CustomButton(text: "اشحن", onPressed: (){
                      Navigation.mainNavigator(context, const ChargeWalletScreen());
                    },color: Config.mainColor,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CustomText(text: homeProvider!.walletModel!.countorders.toString(), fontSize: 16,color: Config.mainColor,),
                          const Spacer(),
                          CustomText(text: "الطلبات المنجزة هذا الشهر : ", fontSize: 16),
                        ],
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all()),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CustomText(text: "${homeProvider!.walletModel!.gain} ر.س", fontSize: 16,color: Config.mainColor,),
                          const Spacer(),
                          CustomText(text: "الدخل هذا الشهر : ", fontSize: 16),
                        ],
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(text: "عمليات الشحن الاخيرة", fontSize: 16),
                      ],
                    ),
                    ListBody(
                      children: List.generate(homeProvider!.walletModel!.data!.length, (index) {
                        return Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              CustomText(text: "${homeProvider!.walletModel!.data![index].card!.price} ر.س", fontSize: 16,color: Config.mainColor,),
                              const Spacer(),
                              CustomText(text: homeProvider!.walletModel!.data![index].card!.createdAt!.substring(0,10), fontSize: 16),
                            ],
                          ),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all()),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
