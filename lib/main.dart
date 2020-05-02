import 'auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.fireBaseUserStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => Wrapper(),
        //   '/inputPart': (context) => InputPartPage(),
        //   '/trialCheck': (context) => TrialCheckProccessPage(),
        //   '/wash': (context) => WashProcessPage(),

        // }
      ),
    );
  }
}
