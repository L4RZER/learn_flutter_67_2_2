//  Step 2: App Screen
import 'dart:async';
import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  // อะไรที่อยากให้ทำก่อนให้เขียนใน initState
  void initState() {
    super.initState();

    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectionStatus = await (Connectivity().checkConnectivity());
    // Implement your internet connection check logic here
    if (connectionStatus == ConnectivityResult.mobile) {
      // Mobile network available.
      _showToast('Mobile network is available');
    } else if (connectionStatus.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      _showToast('Wi-Fi is available');
    } else if (connectionStatus.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      _showToast('Ethernet connection is available');
    } else if (connectionStatus.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      _showToast('VPN connection is active');
    } else if (connectionStatus.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      _showToast('Bluetooth connection is available');
    } else if (connectionStatus.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      _showToast('Connected to a network which is not in the above mentioned networks');
    } else if (connectionStatus.contains(ConnectivityResult.none)) {
      // No available network types
      _showAlertDialog(context, 'No Internet Connection', 'Please check your internet connection and try again.');
    }
    return;
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orangeAccent, Colors.deepOrange],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(0.6, 0.5),
        tileMode: TileMode.repeated,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('./android/assets/images/Darwin.jpg'),
        const SizedBox(height: 50),
        const SpinKitSpinningLines(
          color: Colors.white,
          size: 50.0,
        ),
      ],
    ),
  );
  }
}

void _showToast(String msg, BuildContext context) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 14.0,
  );
  _timer(context);
}

void _timer(BuildContext context){
  Timer(
    const Duration(seconds: 3), 
      () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
    ),
  );
}

void _showAlertDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title, 
          style: TextStyle(
            fontSize: 24, 
            fontFamily: "Alike", 
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(msg),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Alike",
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ],
      );
    },
  );
}


class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Text(
          'Welcome to the second page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}