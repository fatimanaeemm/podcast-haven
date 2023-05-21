import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";

  String password = "";
  bool _obscureText = true;
  FocusScopeNode _focusScopeNode = FocusScopeNode();

  @override
  void dispose() {
    // Dispose the FocusScopeNode when the screen is disposed
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _closeKeyboard() {
    // Unfocus the FocusScopeNode to close the keyboard
    _focusScopeNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var fem = 1.0;
    var ffem = 1.0;
    return GestureDetector(
        onTap: _closeKeyboard,
        child: FocusScope(
          node: _focusScopeNode,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xfff0ecec),
            body: Container(
              padding:
                  EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 120),
              width: double.infinity,
              height: 844 * fem,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Hello There!\nWelcome to Podcast Heaven',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 30, left: 15, right: 15, bottom: 10),
                          height: 100 * fem,
                          width: 250 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xffd9d9d9),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/main.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Email: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      //font: 'Lato',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  )),
                              Container(
                                width: 200 * fem,
                                height: 35 * fem,
                                color: Color(0xccd9d9d9),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5.0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    fillColor: Color(0xccd9d9d9),
                                    focusColor: Color(0xccd9d9d9),
                                    hoverColor: Color(0xccd9d9d9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                    ),
                                  ),
                                  cursorHeight: 28 * fem,
                                  cursorColor: Color(0x54000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Password: ',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  )),
                              Container(
                                width: 200 * fem,
                                height: 35 * fem,
                                color: Color(0xccd9d9d9),
                                child: TextField(
                                  obscureText: _obscureText,
                                  obscuringCharacter: '*',
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIconConstraints: BoxConstraints(
                                      maxWidth: 30.0,
                                    ),
                                    suffixIcon: IconButton(
                                      iconSize: 20 * fem,
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    contentPadding: EdgeInsets.all(5.0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    fillColor: Color(0xccd9d9d9),
                                    focusColor: Color(0xccd9d9d9),
                                    hoverColor: Color(0xccd9d9d9),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xccd9d9d9),
                                      ),
                                    ),
                                    suffixIconColor: Colors.grey,
                                  ),
                                  cursorHeight: 28 * fem,
                                  cursorColor: Color(0x54000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _closeKeyboard();
                        final correctEmail = "daniyahimran@gmail.com";
                        final correctPassword = "password";
                        setState(() {
                          _wrongEmail = false;
                          _wrongPassword = false;
                        });
                        if (password == correctPassword &&
                            email == correctEmail) {
                          Navigator.of(context).pushNamed(HomeScreen.routeName);
                        } else if (email != correctEmail) {
                          setState(() {
                            _wrongPassword = true;
                            _wrongEmail = true;
                            final snackBar = SnackBar(
                              content: Container(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'User doesn\'t exist',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: Color(0xffff004c),
                              duration: Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        } else if (email == correctEmail &&
                            password != correctPassword) {
                          setState(() {
                            _wrongPassword = true;
                          });
                          final snackBar = SnackBar(
                            content: Container(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Password doesn\'t match',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Color(0xffff004c),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(80 * fem, 40 * fem),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffff004c)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text('Login',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2 * ffem / fem,
                              color: Color(0xff141f5a),
                            ),
                          )),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
