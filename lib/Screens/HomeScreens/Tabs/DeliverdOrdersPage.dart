import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/OrderDetailsScreens/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DeliverdOrdersPage extends StatefulWidget {
  const DeliverdOrdersPage({Key? key}) : super(key: key);

  @override
  _DeliverdOrdersPageState createState() => _DeliverdOrdersPageState();
}

class _DeliverdOrdersPageState extends State<DeliverdOrdersPage> {
  late HomeProvider provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider()..getOrders("receved"),
      child: Selector<HomeProvider,OrdersOnProccessState>(
          selector: (context,homeProvider){
            provider = homeProvider;
            return HomeStates.ordersOnProccessState;
          },
          builder: (context, state,child) {
            if(state == OrdersOnProccessState.LOADING){
              return const Center(child:  CircularProgressIndicator());
            }
            if(state == OrdersOnProccessState.ERROR){
              return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
            }
            if(state == OrdersOnProccessState.LOADED && provider.recevedOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.recevedOrderModel!.data![index],));
                  },deliveryPrice: provider.recevedOrderModel!.data![index].deliveryPrice.toString(),status: "receved",vendorName: provider.recevedOrderModel!.data![index].products![0].user!.name!, price: provider.recevedOrderModel!.data![index].price.toString(), orderId: provider.recevedOrderModel!.data![index].id.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider.recevedOrderModel!.data!.length
            );
          }
      ),
    );
  }
}
