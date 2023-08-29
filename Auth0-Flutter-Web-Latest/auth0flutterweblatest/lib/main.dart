import 'package:auth0flutterweblatest/auth_client/client_interface.dart';
import 'package:auth0flutterweblatest/src/client_web.dart';
import 'package:flutter/material.dart';

B2CAuth authWeb = B2CAuth();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authWeb.processStartup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(onPressed: (){authWeb.signIn();},child: Text("Login"),),
      ),
    );
  }


}

