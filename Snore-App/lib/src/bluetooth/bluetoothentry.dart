import 'package:flutter/material.dart'
    show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;
import 'package:flutter/src/foundation/key.dart';
import 'SelecionarDispositivo.dart';
import 'HomePage.dart';
import 'package:provider/provider.dart';
import 'provider/StatusConexaoProvider.dart';

// void main() {
//   runApp(MyApp());
// }

class Bluetooth extends StatelessWidget {
  const Bluetooth({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // const Bluetooth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StatusConexaoProvider>.value(
              value: StatusConexaoProvider()),
        ],
        child: MaterialApp(
          title: 'Xerocasa',
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/selectDevice': (context) => const SelecionarDispositivoPage(),
          },
        ));
  }
}
