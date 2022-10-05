import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/HelperFunctions.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/OrderDetailsScreens/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AvailableOrdersPage extends StatefulWidget {
   const AvailableOrdersPage({Key? key}) : super(key: key);

  @override
  _AvailableOrdersPageState createState() => _AvailableOrdersPageState();
}

class _AvailableOrdersPageState extends State<AvailableOrdersPage> {
  late HomeProvider provider;
  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 0),() async {
      position = await determinePosition();
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getOrders("online");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, provider,child) {
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADING && context.read<HomeProvider>().onlineOrderModel==null && position == null){
            return const Center(child:  CircularProgressIndicator());
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.ERROR){
            return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADED && provider.onlineOrderModel!.data!.isEmpty){
            return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
          }
          return context.read<HomeProvider>().onlineOrderModel==null || position==null?const SizedBox():ListView.separated(
              itemBuilder: (context,index){
                return OrderCard(onTap: (){
                  Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onlineOrderModel!.data![index]));
                },deliveryPrice: provider.onlineOrderModel!.data![index].deliveryPrice.toString(),status: "online",vendorName: provider.onlineOrderModel!.data![index].products![0].user!.name!,distance1: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse(provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()), double.parse(provider.onlineOrderModel!.data![index].products![0].user!.lang.toString())),
                  distance2: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse(provider.onlineOrderModel!.data![index].lat.toString()), double.parse(provider.onlineOrderModel!.data![index].lang.toString())), price: provider.onlineOrderModel!.data![index].price.toString(), orderId: provider.onlineOrderModel!.data![index].id.toString(),
                );
              },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
              },
              itemCount: provider.onlineOrderModel!.data!.length
          );
        }
    );
  }
}
