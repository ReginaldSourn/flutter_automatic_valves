import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  TextEditingController timeinput1Start = TextEditingController();
  TextEditingController timeinput1Stop = TextEditingController();
  TextEditingController timeinput2Start = TextEditingController();
  TextEditingController timeinput2Stop = TextEditingController();
  TextEditingController timeinput3Start = TextEditingController();
  TextEditingController timeinput3Stop = TextEditingController();
  bool statusV1 = false;
  bool statusV2 = false;
  bool statusV3 = false;
  bool mnorauto = false;
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV1Start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV2Start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV3Start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV1Stop = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV2Stop = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _timeV3Stop = TimeOfDay(hour: 0, minute: 0);
  var selectedTime24Hour;

  //text editing controller for text field
  Future<TimeOfDay?> _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,

    );
    if (newTime != null) {
      setState(() {
        _time = newTime;

      });
      return _time;
    }
  }

  @override
  void initState() {
    timeinput1Start.text = "";
    timeinput1Stop.text = "";
    timeinput2Start.text = "";
    timeinput2Stop.text = "";
    timeinput3Start.text = "";
    timeinput3Stop.text = "";//set the initial value of text field
    super.initState();
  }
  bool checkInput(){
    if ((timeinput1Start.text.isNotEmpty) && (timeinput1Stop.text.isNotEmpty)
    && (timeinput2Start.text.isNotEmpty) &&  (timeinput2Stop.text.isNotEmpty) &&
    (timeinput3Start.text.isNotEmpty) && (timeinput3Stop.text.isNotEmpty)){
        return true;
    }
    else {
      return false;
    }
  }
  String? _selectedTime;
  @override
  String getValvesList (bool status, String number, String starttime, String stoptime)  {
    int starttime_ = int.parse(starttime.substring(0,2))*3600 + int.parse(starttime.substring(3,5))*60;
    int stoptime_ =  int.parse(stoptime.substring(0,2))*3600 + int.parse(stoptime.substring(3,5))*60;
    int minuteinterval;
    String intervalhour, intervalminute;
    if (status) {
      if (starttime_ > stoptime_) {
        intervalhour =
            (((stoptime_ + 86400) - (starttime_)) / 3600).toInt().toString();
        minuteinterval =
            ((((stoptime_ + 86400) - (starttime_)) % 3600) / 60).toInt();
        if (minuteinterval > 60) {
          intervalminute = ((minuteinterval % 60) - 20).toString();
        }
        else {
          intervalminute = minuteinterval.toString();
        }
      }
      else {
        intervalhour = (((stoptime_) - (starttime_)) / 3600).toInt().toString();
        intervalminute =
            ((((stoptime_) - (starttime_)) % 3600) / 60).toInt().toString();
        // if (minuteinterval > 60){
        //   intervalminute = ((minuteinterval % 60)-20).toString();
        // }
        // else{
        //   intervalminute = minuteinterval.toString();
        // }
      }
      return " កំណត់វា៉ល់ " + number + ": ចាប់ពីម៉ោង " + starttime +
          " រហូតដល់ " + stoptime + " មានរយះពេល " + intervalhour + " ម៉ោង " +
          intervalminute + " នាទី ";
    }
    else{
      return " កំណត់វា៉ល់ " + number + ": មិនអោយដំណើរការ";
    }
    }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ការកំណត់បានត្រឹមត្រូវ'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('បានកំណត់:'),
                Text("==========================="),
                Text(getValvesList(statusV1,"1",timeinput1Start.text,timeinput1Stop.text)),
                Text("==========================="),
                Text(getValvesList(statusV2,"2",timeinput2Start.text,timeinput2Stop.text)),
                Text("==========================="),
                Text(getValvesList(statusV3,"3",timeinput3Start.text,timeinput3Stop.text)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('មិនទាន់'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ផ្ងើរការកំណត់'),
              onPressed: () {

              },
            ),
          ],
        );
      },
    );
  }
  Future<void> errorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ការកំណត់មិនត្រឹមត្រូវ'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[

                Text('សូមមេត្តាបំពេញ តារាងកំណត់ម៉ោងអោយបានត្រឹមត្រូវ'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('បាទ/ចាស់'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
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

              height: 320.0,
              width: 380,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
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

                alignment: Alignment.center,

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Row(
                children: <Widget>[
                Container(height: 50, width:90,
                          alignment:Alignment.center,
                          child:Text("វា៉ល់ ",
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                      ),
                Container(height: 50, width:90,
                    alignment:Alignment.center,
                    child:Text("ម៉ោងបើក", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                Container(height: 50, width:90,
                     alignment:Alignment.centerRight,
                     child:Text("ម៉ោងបិទ",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                Container(
                    height: 50, width:100,
                alignment:Alignment.center,
                child:Text("ដំណើរការ",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                  ],
                  ),

                  Row(
                    children: <Widget>[
                      Container(height: 50, width:80,
                          alignment:Alignment.center,
                          child:Text("វា៉ល់ 1",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)),
                      Container(height: 50, width:100,
                          alignment:Alignment.center,
                          child: TextField(
                            controller: timeinput1Start,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            decoration: const InputDecoration(

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),

                                icon: Icon(Icons.timer, color: Colors.white), //icon of text field

                            ),
                            readOnly: true,
                            onTap:() async{

                              _timeV1Start= await _selectTime() as TimeOfDay;
                              setState(() {
                                timeinput1Start.text = _timeV1Start.format(context); //set the value of text field.
                              });
                            },//end async
                          ),),
                      Container(height: 50, width:100,
                          alignment:Alignment.center,
                          child:
                          TextField(
                            controller: timeinput1Stop,
                            cursorColor: Colors.white,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),

                              icon: Icon(Icons.timer, color: Colors.white),


                              // border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.green)),
                              //icon of text field
                                //label text of field
                            ),
                            readOnly: true,
                            onTap:() async{

                              _timeV1Stop= await _selectTime() as TimeOfDay;
                              setState(() {
                                timeinput1Stop.text = _timeV1Stop.format(context); //set the value of text field.
                              });
                            },//end async
                          ),),
                      Container(
                        height: 50, width:80,
                          alignment:Alignment.center,
                          child:FlutterSwitch(
                                      width: 90.0,
                                      height: 45.0,
                                      valueFontSize: 10.0,
                                      toggleSize: 45.0,
                                      value: statusV1,
                                      borderRadius: 30.0,
                                      padding: 8.0,
                                      activeColor: Color(0xFF32a858),
                                      showOnOff: true,
                                      activeText: "បើក",
                                      inactiveText: "បិទ",
                                      activeTextColor: Color(0xFFFFFFFF),
                                      onToggle: (val) {
                                        setState(() {
                                          statusV1 = val;
                                        });
                                      }

                      ),
    ),],
                  ),

                  Row(
                    children: <Widget>[
                      Container(height: 50, width:80,
                          alignment:Alignment.center,
                          child:Text("វា៉ល់ 2",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)),
                      Container(height: 50, width:100,
                        alignment:Alignment.center,
                        child: TextField(
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          controller: timeinput2Start,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),

                            icon: Icon(Icons.timer, color: Colors.white),//icon of text field

                          ),
                          readOnly: true,
                          onTap:() async{

                            _timeV2Start= await _selectTime() as TimeOfDay;
                            setState(() {
                            timeinput2Start.text = _timeV2Start.format(context); //set the value of text field.
                            });
                          },//end async
                        ),),
                      Container(height: 50, width:100,
                        alignment:Alignment.center,
                        child:
                        TextField(
                          controller: timeinput2Stop,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),

                              icon: Icon(Icons.timer, color: Colors.white), //icon of text field
                            //label text of field
                          ),
                          readOnly: true,
                          onTap:() async{

                            _timeV2Stop= await _selectTime() as TimeOfDay;
                            setState(() {
                              timeinput2Stop.text = _timeV2Stop.format(context); //set the value of text field.
                            });
                          },//end async
                        ),),
                      Container(
                        height: 50, width:80,
                        alignment:Alignment.center,
                        child:FlutterSwitch(
                            width: 90.0,
                            height: 45.0,
                            valueFontSize: 10.0,
                            toggleSize: 45.0,
                            value: statusV2,
                            borderRadius: 30.0,
                            padding: 8.0,
                            activeColor: Color(0xFF32a858),
                            showOnOff: true,
                            activeText: "បើក",
                            inactiveText: "បិទ",
                            activeTextColor: Color(0xFFFFFFFF),
                            onToggle: (val) {
                              setState(() {
                                statusV2 = val;
                              });
                            }

                        ),
                      ),],
                  ),
                  Row(
                    children: <Widget>[
                      Container(height: 50, width:80,
                          alignment:Alignment.center,
                          child:Text("វា៉ល់ 3", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)),
                      Container(height: 50, width:100,
                        alignment:Alignment.center,
                        child: TextField(
                          controller: timeinput3Start,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),

                            icon: Icon(Icons.timer, color: Colors.white), //icon of text field

                          ),
                          readOnly: true,
                          onTap:() async{

                            _timeV3Start= await _selectTime() as TimeOfDay;
                            setState(() {
                            timeinput3Start.text = _timeV3Start.format(context); //set the value of text field.
                            });
                          },//end async
                        ),),
                      Container(height: 50, width:100,
                        alignment:Alignment.center,
                        child:
                        TextField(
                          controller: timeinput3Stop,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),

                            icon: Icon(Icons.timer, color: Colors.white), //icon of text field
                            //label text of field
                          ),
                          readOnly: true,
                          onTap:() async{

                            _timeV3Stop= await _selectTime() as TimeOfDay;
                            setState(() {
                              timeinput3Stop.text = _timeV3Stop.format(context); //set the value of text field.
                            });
                          },//end async
                        ),),
                      Container(
                        height: 50, width:80,
                        alignment:Alignment.center,
                        child:FlutterSwitch(
                            width: 90.0,
                            height: 45.0,
                            valueFontSize: 10.0,
                            toggleSize: 45.0,
                            value: statusV3,
                            borderRadius: 30.0,
                            padding: 8.0,
                            activeColor: Color(0xFF32a858),
                            showOnOff: true,
                            activeText: "បើក",
                            inactiveText: "បិទ",
                            activeTextColor: Color(0xFFFFFFFF),
                            onToggle: (val) {
                              setState(() {
                                statusV3 = val;
                              });
                            }

                        ),
                      ),],
                  ),

                  Row(
                    children: <Widget>[
                      Container(
                          alignment:Alignment.center,
                      ),
                      Container(
                        alignment:Alignment.center,
                        ),
                      Container(
                        alignment:Alignment.center,
                      ),
                      Container(
                        height: 45,
                        alignment:Alignment.center,

                      ),],
                  ),
                  Row(
                    children: <Widget>[
                      Container(height: 45, width:90,
                        alignment:Alignment.center,
                      ),
                      Container(height: 45, width:90,
                        alignment:Alignment.center,
                      ),

                      Container(
                        height: 45, width:170,
                        margin: EdgeInsets.only(left: 30),
                        alignment:Alignment.center,
                        child:FloatingActionButton.extended(

                          onPressed: (


                              ) async {
                         if (checkInput()){
                            _showMyDialog();
                            }
                         else{
                           errorDialog();
                           }
                        },
                          icon: Icon(Icons.save_outlined),
                          label:Text("កំណត់",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),),

                      ),],
                  ),

                ],
              )
            ),
        ],),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.

    );}
}

