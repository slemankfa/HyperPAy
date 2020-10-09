import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

// usfel Link : https://medium.com/simicart-developers/integrating-hyperpay-into-a-react-native-project-72c688bd7161
// usfel Link : https://stackoverflow.com/questions/34765190/how-to-add-aar-dependency-in-library-module 
// when add ibjective c header we added it in (Runner-Bridging-Header.h)
  static const platform = const MethodChannel("com.env.pay/payemntMethod");

  Future<void> _getPaymentResponse() async {
    try {
      var result = await platform.invokeMethod(
          'getPaymentMetod', "F5188DE7144C4DEBBF5CBF4262CD056A.uat01-vm-tx03");
      print(result.toString());
    } on PlatformException catch (e) {
      print("Failed to get payment metohd: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Payment'),
              onPressed: _getPaymentResponse,
            ),
          ],
        ),
      ),
    );
  }
}
