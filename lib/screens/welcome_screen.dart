import 'package:awesome_webshop/components/awesome_webshop_logo.dart';
import 'package:awesome_webshop/components/welcome_screen/welcome_button.dart';
import 'package:awesome_webshop/screens/shopping_cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'account_screen.dart';
FirebaseAuth auth = FirebaseAuth.instance;


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool verified = false;

  void signInAnonymously() async {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    if (auth.currentUser != null) {
      setState(() {
        verified = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (auth.currentUser == null) {
      verified = false;
      signInAnonymously();
    } else {
      verified = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightGreen.shade300, Colors.teal.shade900])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(48.0),
                  child: Hero(
                    tag: kLogoHeroTag,
                    child: AwesomeWebshopLogo(
                      fontSize: 48.0,
                    ),
                  ),
                ),
                verified ? WelcomeButton(text: 'Producten') : SizedBox(),
                verified ? WelcomeButton(text: 'Registreer nu', routeID: ShoppingCartScreen.id,) : SizedBox(),
                verified ? WelcomeButton(text: 'Log in', routeID: AccountScreen.id,) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



