import 'package:flutter/material.dart';
import 'package:valves_a/config_timer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF88b04b),
        // textSelectionColor: const Color(0xFFFFFFFF),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 6.0, color: Color(0xFFFFFFFF)),
          headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.normal),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind',  color: Color(0xFFFFFFFF)),
        )
        ,
      ),
      home: const MyHomePage(title: 'ValveA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // set variable declarations here.


  int _counter = 0;
  bool mnorauto = false;
  bool valve1 = false;
  bool valve2 = false;
  bool valve3 = false;
  final String host="http://192.168.4.1/";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      //   backgroundColor: Colors.green,
      // ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200.0,
              width: 450,
              child: Align(
                alignment: Alignment.center,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'ប្រព័ន្ឋវ៉ាល់ស្វ័យប្រវត្តិ',

                      style:const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),

                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child:FlutterSwitch(
                        width: 130.0,
                        height: 60.0,
                        valueFontSize: 25.0,
                        toggleSize: 45.0,
                        value: mnorauto,
                        borderRadius: 30.0,
                        padding: 8.0,
                        activeColor: Color(0xFF32a858),
                        showOnOff: true,
                        activeText: "បើក",
                        inactiveText: "បិទ",
                        activeTextColor: Color(0xFFFFFFFF),
                        onToggle: (val) {
                          setState(() {
                            mnorauto = val;
                          });
                        },
                      ),

                    ),


                  ],
                ),
              ),

            ),

            Visibility(

              visible: !mnorauto,
              child: Container(

                  alignment: Alignment.center,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF93b75c),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 10,
                        blurRadius: 20,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],),
                  height: 200, width: 300,

                  child:
                  Column(
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children:  <Widget>[

                        Row(children: <Widget>[
                          Container(height: 50, width:100,
                              alignment:Alignment.centerRight,

                              child:Text("វា៉ល់ 1",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                          Container(
                            height: 50, width:200,
                            alignment:Alignment.centerLeft,
                            child:FlutterSwitch(
                                width: 90.0,
                                height: 45.0,
                                valueFontSize: 13.0,
                                toggleSize: 45.0,
                                value: valve1,
                                borderRadius: 30.0,
                                padding: 8.0,
                                activeColor: Color(0xFF32a858),
                                showOnOff: true,
                                activeText: "បើក",
                                inactiveText: "បិទ",
                                activeTextColor: Color(0xFFFFFFFF),
                                onToggle: (val) {
                                  setState(() {
                                    valve1 = val;
                                  });
                                }

                            ),

                          ),

                        ],),
                        Row(children: <Widget>[
                          Container(height: 50, width:100,
                              alignment:Alignment.centerRight,

                              child:Text("វា៉ល់ 2",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                          Container(
                            height: 50, width:200,
                            alignment:Alignment.centerLeft,
                            child:FlutterSwitch(
                                width: 90.0,
                                height: 45.0,
                                valueFontSize: 13.0,
                                toggleSize: 45.0,
                                value: valve2,
                                borderRadius: 30.0,
                                padding: 8.0,
                                activeColor: Color(0xFF32a858),
                                showOnOff: true,
                                activeText: "បើក",
                                inactiveText: "បិទ",
                                activeTextColor: Color(0xFFFFFFFF),
                                onToggle: (val) {
                                  setState(() {
                                    valve2 = val;
                                  });
                                }

                            ),

                          ),

                        ],),
                        Row(children: <Widget>[
                          Container(height: 50, width:100,
                              alignment:Alignment.centerRight,

                              child:Text("វា៉ល់ 3",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                          Container(
                            height: 50, width:200,
                            alignment:Alignment.centerLeft,
                            child:FlutterSwitch(
                                width: 90.0,
                                height: 45.0,
                                valueFontSize: 13.0,
                                toggleSize: 45.0,
                                value: valve3,
                                borderRadius: 30.0,
                                padding: 8.0,
                                activeColor: Color(0xFF32a858),
                                showOnOff: true,
                                activeText: "បើក",
                                inactiveText: "បិទ",
                                activeTextColor: Color(0xFFFFFFFF),
                                onToggle: (val) {
                                  setState(() {
                                    valve3 = val;
                                  });
                                }

                            ),

                          ),

                        ],),

                      ]
                  )


              ),


            ),
            SizedBox(height: 20),
            SizedBox(
              width: 100.0,
              height: 100.0,

              child:
              FloatingActionButton(

                child: Icon(Icons.wifi, size:80, color: Colors.red,),
                onPressed: () {

                  // AppSettings.openWIFISettings();
                }
                ,)
              ,)
          ],

        ),

      ),

      floatingActionButton:

      Container(
        height: 170.0,
        width: 170.0,
        child: FittedBox(

          child:FloatingActionButton.extended(


            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomDialogBox(title: "Custom Dialog Demo",
                  descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  text: "Yes",)),
              );

            },
            label: Text("កំណត់ម៉ោង"),
            icon:  const Icon(Icons.settings),
            tooltip: 'Increment',
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
