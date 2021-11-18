import 'package:awesome_webshop/components/awesome_webshop_logo.dart';
import 'package:awesome_webshop/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  String routeIDFromCall;


  RegistrationScreen({this.routeIDFromCall = WelcomeScreen.id});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registreren', style: GoogleFonts.roboto(),),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightGreen.shade300, Colors.teal.shade900])
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Je emailadres',
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Je wachtwoord',
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Registreer',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 24
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password
                              ); // Wachten op nieuwe user

                              if (newUser != null) {
                                Navigator.pushNamed(context, widget.routeIDFromCall);
                              }

                              setState(() {
                                showSpinner = false;
                              });

                            } catch(e) {
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
