import 'package:ebranchdelivery/Helpers/Config.dart';
import 'package:ebranchdelivery/Providers/Home/HomeProvider.dart';
import 'package:ebranchdelivery/Screens/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'Providers/Auth/AuthProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: OKToast(
        child: MaterialApp(
          title: 'E-Branch',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Config.mainColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.white,iconTheme: IconThemeData(color: Colors.white)),
            textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme).copyWith(
              bodyText1: GoogleFonts.cairo(textStyle: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          home: const Splashscreen(),
        ),
      ),
    );
  }
}
