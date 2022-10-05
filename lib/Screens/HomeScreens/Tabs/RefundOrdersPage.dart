import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Navigation.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Screens/HomeScreens/OrderDetailsScreens/OrderDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RefundOrdersPage extends StatefulWidget {
  const RefundOrdersPage({Key? key}) : super(key: key);

  @override
  _RefundOrdersPageState createState() => _RefundOrdersPageState();
}

class _RefundOrdersPageState extends State<RefundOrdersPage> {
  late HomeProvider provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider()..getOrders("back"),
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
            if(state == OrdersOnProccessState.LOADED && provider.backOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.backOrderModel!.data![index],));
                  },deliveryPrice: provider.backOrderModel!.data![index].deliveryPrice.toString(),status: "debug",vendorName: provider.backOrderModel!.data![index].products![0].user!.name!, price: provider.backOrderModel!.data![index].price.toString(), orderId: provider.backOrderModel!.data![index].id.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider.backOrderModel!.data!.length
            );
          }
      ),
    );
  }
}
