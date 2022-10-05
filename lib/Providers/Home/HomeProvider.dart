import 'package:ebranchdelivery/Models/OrderModel.dart';
import 'package:ebranchdelivery/Models/ReasonsModel.dart';
import 'package:ebranchdelivery/Models/WalletModel.dart';
import 'package:ebranchdelivery/Providers/Home/HomeStates.dart';
import 'package:ebranchdelivery/Repositories/HomeRepository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeProvider extends ChangeNotifier{

  OrderModel? onlineOrderModel;
  OrderModel? onproccessOrderModel;
  OrderModel? debugOrderModel;
  OrderModel? backOrderModel;
  OrderModel? recevedOrderModel;
  Future getOrders(status)async{
    HomeStates.ordersOnProccessState = OrdersOnProccessState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.getOrders(status);
      if(status=="online") {
        onlineOrderModel = OrderModel.fromJson(response);
      }else if(status=="onproccess"){
        onproccessOrderModel = OrderModel.fromJson(response);
      }else if(status=="debug"){
        debugOrderModel = OrderModel.fromJson(response);
      }else if(status=="back"){
        backOrderModel = OrderModel.fromJson(response);
      }else if(status=="receved"){
        recevedOrderModel = OrderModel.fromJson(response);
      }
      HomeStates.ordersOnProccessState = OrdersOnProccessState.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.ordersOnProccessState = OrdersOnProccessState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  late ReasonsModel reasonsModel;
  int radioButtonValue  = 0;

  changeValue(v){
    radioButtonValue = v;
    notifyListeners();
  }
  Future getReasons(type)async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.getReasons(type);
      reasonsModel = ReasonsModel.fromJson(response);
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  WalletModel? walletModel;

  Future getWallet()async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.getWallet();
      walletModel = WalletModel.fromJson(response);
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Map<String,dynamic>? response;
  Future<Map<String,dynamic>> getRate()async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      response = await HomeRepository.getRate();
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
      return response!;
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<Map<String,dynamic>> changeOrderStatus(formData)async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.changeOrderStatus(formData);
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<Map<String,dynamic>> finishOrder(Map<String,String> formData,img)async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.finishOrder(formData,img);
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

  Future<Map<String,dynamic>> chargeWallet(num)async{
    HomeStates.reasonsState = ReasonsState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await HomeRepository.chargeWallet(num);
      HomeStates.reasonsState = ReasonsState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.reasonsState = ReasonsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Map<String,dynamic>? termsResponse;
  terms(type)async{
    HomeStates.fetchTermsState = FetchTermsState.LOADING;
    notifyListeners();
    try{
      termsResponse = await HomeRepository.terms(type);
      HomeStates.fetchTermsState = FetchTermsState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      HomeStates.fetchTermsState = FetchTermsState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }

}