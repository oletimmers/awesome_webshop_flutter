import 'package:awesome_webshop/screens/login_screen.dart';
import 'package:awesome_webshop/screens/registration_screen.dart';
import 'package:awesome_webshop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AccountScreen extends StatefulWidget {
  static const String id = 'account_screen';

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoggedInWithEmail() {
    if (auth.currentUser == null) {
      return false;
    } else {
      return !auth.currentUser!.isAnonymous;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: isLoggedInWithEmail() ? [
          Text('Je Account',
            style: GoogleFonts.roboto(
                fontSize: 26
            ),
          ),
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
        ] :
        [
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
        ]
        ,
      ),
    );
  }
}
