import 'package:flutter/material.dart';

class Config {
  static MaterialColor mainColor = const MaterialColor(0xff2BC2C1,{
    50:Color.fromRGBO(4,131,184, .1),
    100:Color.fromRGBO(4,131,184, .2),
    200:Color.fromRGBO(4,131,184, .3),
    300:Color.fromRGBO(4,131,184, .4),
    400:Color.fromRGBO(4,131,184, .5),
    500:Color.fromRGBO(4,131,184, .6),
    600:Color.fromRGBO(4,131,184, .7),
    700:Color.fromRGBO(4,131,184, .8),
    800:Color.fromRGBO(4,131,184, .9),
    900:Color.fromRGBO(4,131,184, 1),
  });

  static Color buttonColor = const Color(0xff837E83);
  static double responsiveHeight (context)=> MediaQuery.of(context).size.height;
  static double responsiveWidth (context)=> MediaQuery.of(context).size.width;

  // network constants
  static Uri setApi (String endPoint){
    return  Uri.parse("http://e-branch.feckrah.com/api/$endPoint");
  }
  static String url = "http://e-branch.feckrah.com/";


  static String googleApiAndroid = "AIzaSyD38YQy10FmPig_gdVZAaFmbYh9znMoPds";
  static String googleApiIOS = "AIzaSyCT0kQS59FPeZtL9tRvshyGDz1iToySVo0";
}