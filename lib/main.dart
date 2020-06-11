import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: Color(0xFFfc443c),
        accentColor: Color(0xFFfc443c),
        fontFamily: 'Nunito',
        textTheme: TextTheme(
          button: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),      
      home: MyHomePage(
        title: 'Starter Page'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: Theme.of(context).accentColor,
                padding: const EdgeInsets.all(10.0),
                child:
                    Text('Mulai Pesanan', style: Theme.of(context).textTheme.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
