import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../../utils/globals.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
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
              controller:passwordController,
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
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
              onPressed: () {
                // snackbarKey.currentState?.showSnackBar(const SnackBar(
                //   content: Text("Welcome to Sleep App!  ❤🤗"),
                //   behavior: SnackBarBehavior.floating,
                //   duration: Duration(seconds: 2),
                //   backgroundColor: Color(0xff3253BD),
                // ));
                signUp().then((value) {
                  print(value.additionalUserInfo);
                  if (value.additionalUserInfo.isNewUser) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }), (route) => false);
                  }
                });
              },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  Future signUp() async {
    try {
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      return response;
    } on  FirebaseAuthException catch (e){
      print(e);
    }
  }

}