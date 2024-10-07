import 'package:flutter/material.dart';

import 'package:jyothi_labs/view/widgets/auth_button.dart';
import 'package:jyothi_labs/view/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jyothi_labs/view_model/repos/login_auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Controllers for email and password text fields
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close keyboard on tap
        },
        child: Scaffold(
          resizeToAvoidBottomInset:
              false, // Allow layout to adjust for the keyboard
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 320,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'JYOTHI LABS',
                            style: GoogleFonts.mulish(
                                letterSpacing: 1,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Main body content wrapped inside Expanded
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.black,
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(left: 22, right: 22, top: 14),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                'Login',
                                style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    fontSize: 36),
                              ),
                              SizedBox(height: 30),
                              CustomizableTextFieldwidget(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                labelText: "emilys",
                              ),
                              SizedBox(height: 20),
                              CustomizableTextFieldwidget(
                                controller: passwordController,
                                labelText: 'emailypass',
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password ?',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              AuthenticateSaveButton(
                                buttonText: 'Login',
                                onpressed: () {
                                  loginUser(context, emailController,
                                      passwordController);
                                },
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Don\'t have an account? SignUp',
                                style: GoogleFonts.mulish(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
