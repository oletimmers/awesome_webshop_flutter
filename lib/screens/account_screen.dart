import 'package:awesome_webshop/components/account_screen/user_orders.dart';
import 'package:awesome_webshop/screens/login_screen.dart';
import 'package:awesome_webshop/screens/registration_screen.dart';
import 'package:awesome_webshop/screens/welcome_screen.dart';
import 'package:awesome_webshop/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'new_product_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AccountScreen extends StatefulWidget {
  static const String id = 'account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  bool showAdminFunctions = false;

  @override
  void initState() {
    super.initState();
    checkAdmin();
  }

  void checkAdmin() async {
    bool isAdmin = await AuthService.instance.isUserAdmin();
    setState(() {
      showAdminFunctions = isAdmin;
    });
  }

  Widget getAdminFunction() {
    if (!showAdminFunctions) {
      return SizedBox();
    } else {
      return Container(
        padding: EdgeInsets.only(top: 8.0),
        height: 38.0,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.teal),
            ),
            onPressed: () {
              Navigator.pushNamed(context, NewProductScreen.id);
            },
            child: Text('Voeg nieuw product toe'),
        ),
      );
    }
  }

  List<Widget> getAccountInfo() {
    return [Text('Je Account',
      style: GoogleFonts.roboto(
          fontSize: 26
      ),
    ),
      getAdminFunction(),
      UserOrders(),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.lightGreen.shade300),
          ),
          onPressed: () {
            auth.signOut();
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
          child: Text('Log uit')
      ),
    ];
  }

  List<Widget> getLoginAndRegisterWidgets() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text('Je bent niet ingelogd, maak een account aan of log in met een bestaand account.',
          style: GoogleFonts.roboto(
              fontSize: 16
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.teal),
          ),
          child: Text(
            'Registreer',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen(routeIDFromCall: AccountScreen.id)),
            );
          },
        ),
      ),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.lightGreen.shade300),
        ),
        child: Text(
          'Log in',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen(routeIDFromCall: AccountScreen.id)),
          );
        },
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AuthService.instance.isLoggedInWithEmail() ? getAccountInfo() : getLoginAndRegisterWidgets()
        ,
      ),
    );
  }
}
