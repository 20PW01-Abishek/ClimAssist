import 'package:clim_assist/constants.dart';
import 'package:flutter/material.dart';

TextField textFieldWidget(String text, IconData icon, bool isPassword,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(color: ColorConstants.secondaryColor),
    decoration: InputDecoration(
        prefixIcon: Icon(icon, color: ColorConstants.secondaryColor),
        labelText: text,
        labelStyle: TextStyle(color: ColorConstants.secondaryColor),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: ColorConstants.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )),
  );
}

Container SignInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: ElevatedButton(
          onPressed: () {},
          child: Text(
            isLogin ? "Sign In" : "Sign Up",
            style: TextStyle(
                color: ColorConstants.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                return Colors.white;
              }),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))))));
}
