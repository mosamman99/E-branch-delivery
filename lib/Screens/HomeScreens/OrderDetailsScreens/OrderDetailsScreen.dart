import 'package:ebranchdelivery/Components/Components.dart';
import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Models/OrderModel.dart';
import 'package:flutter/material.dart';

import 'ClientPage.dart';
import 'StorePage.dart';
class OrderDetailsScreen extends StatefulWidget {
  Data? order;
  OrderDetailsScreen({Key? key,required this.order}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "تفاصيل الطلب"),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
                indicatorWeight: 1,
                indicatorColor: Config.mainColor,
                tabs: <Widget>[
                  Tab(child: Text("المتجر",style: TextStyle(color: Config.mainColor),),),
                  Tab(child: Text("العميل",style: TextStyle(color: Config.mainColor),),),
                ]
            ),

             Expanded(
              child: TabBarView(
                  children: <Widget>[
                    StorePage(order: widget.order),
                    ClientPage(order: widget.order),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
