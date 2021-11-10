

String url=
    "http://192.168.4.1/" ;//IP Address which is configured in NodeMCU Sketch
getInitLedState() async {
  print('start connect web');
  try {

    va.response = await http.get(Uri.parse(url));
    setState(() {
      _status = 'On';
      print(_status);
    });
  } catch (e) {
    // If NodeMCU is not connected, it will throw error
    print(e);

    if (this.mounted) {
      setState(() {
        _status = 'Not Connected';
        print("not connect");
      });
    }
  }
}

SendConfig() async {
  print('start Send Config');
  try {

    va.response = await http.get(Uri.parse(url+'manualmode'));
    setState(() {
      _status = va.response.body;
      print(va.response.body);
    });
  } catch (e) {
    // If NodeMCU is not connected, it will throw error
    print(e);
    displaySnackBar(context, 'Module Not Connected');
  }
}
Future<String> configToSend() async {
  String config='config';
  timeinput1Start.text;
  return config;
}