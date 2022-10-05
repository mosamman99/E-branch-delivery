import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/OrderDetailsScreens/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
class OnProccessingOrdersPage extends StatefulWidget {
  const OnProccessingOrdersPage({Key? key}) : super(key: key);

  @override
  _OnProccessingOrdersPageState createState() => _OnProccessingOrdersPageState();
}

class _OnProccessingOrdersPageState extends State<OnProccessingOrdersPage> {
  late HomeProvider provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getOrders("onproccess");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, provider,child) {
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADING && context.read<HomeProvider>().onproccessOrderModel==null){
            return const Center(child:  CircularProgressIndicator());
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.ERROR){
            return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADED && provider.onproccessOrderModel!.data!.isEmpty){
            return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
          }
          return ListView.separated(
              itemBuilder: (context,index){
                return OrderCard(onTap: (){
                  Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onproccessOrderModel!.data![index],));
                },status: "onproccess",vendorName: provider.onproccessOrderModel!.data![index].products![0].user!.name!, price: provider.onproccessOrderModel!.data![index].price.toString(), orderId: provider.onproccessOrderModel!.data![index].id.toString(), deliveryPrice: provider.onproccessOrderModel!.data![index].deliveryPrice.toString(),
                );
              },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
              },
              itemCount: provider.onproccessOrderModel!.data!.length
          );
        }
    );
  }
}
