import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:awesome_webshop/screens/account_screen.dart';
import 'package:awesome_webshop/screens/login_screen.dart';
import 'package:awesome_webshop/screens/main_screen.dart';
import 'package:awesome_webshop/screens/new_product_screen.dart';
import 'package:awesome_webshop/screens/products_screen.dart';
import 'package:awesome_webshop/screens/registration_screen.dart';
import 'package:awesome_webshop/screens/shopping_cart_screen.dart';
import 'package:awesome_webshop/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Winkelmandje>(
      create: (_) => Winkelmandje(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Awesome Webshop',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.teal,
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              accentColor: Colors.lightGreen.shade300,
          ),
        ),
        home: WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ProductsScreen.id: (context) => MainScreen(initialIndex: 0,),
          ShoppingCartScreen.id: (context) => MainScreen(initialIndex: 1,),
          AccountScreen.id: (context) => MainScreen(initialIndex: 2,),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          NewProductScreen.id: (context) => NewProductScreen(),
        },
      ),
    );
  }
}

