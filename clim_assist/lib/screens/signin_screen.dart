import 'package:clim_assist/constants.dart';
import 'package:clim_assist/screens/signup_screen.dart';
import 'package:clim_assist/widgets/common_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  // const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: ColorConstants.primaryColor),
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      textFieldWidget("Enter username", Icons.person_2_rounded,
                          false, _emailTextController),
                      SizedBox(height: 15),
                      textFieldWidget("Enter Password", Icons.lock, true,
                          _passwordTextController),
                      SizedBox(height: 20),
                      SignInSignUpButton(context, true, () {}),
                      signUpOption()
                    ],
                  )),
            )));
  }

  Row signUpOption() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "Dont have an account ?",
        style: TextStyle(color: Colors.amber),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));

        },
        child:const Text(
          "Sign up",
          style:TextStyle(color:Colors.amberAccent,fontWeight: FontWeight.bold)
        )
      )
    ]);
  }
}
