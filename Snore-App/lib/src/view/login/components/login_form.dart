import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleep/src/view/home/home_screen.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../../constants.dart';
import '../../signup/signup_screen.dart';
import '../../../utils/globals.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                  // snackbarKey.currentState?.showSnackBar(const SnackBar(
                  //   content: Text("Welcome to Snore Detection!  ❤🤗"),
                  //   behavior: SnackBarBehavior.floating,
                  //   duration: Duration(seconds: 2),
                  //   backgroundColor: Color(0xff3253BD),
                  // ));
                  loginIn().then((value) {
                    print(value.additionalUserInfo);
                    if(!value.additionalUserInfo.isNewUser){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                            return const HomeScreen();
                          }), (route) => false);
                    }
                  }
                  );


              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future loginIn() async {
    final response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    return response;
  }
}
