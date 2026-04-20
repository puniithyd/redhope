import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/donor_registration.dart';
import 'screens/donor_list.dart';
import 'screens/request_blood.dart';

void main() {
  runApp(BloodConnectApp());
}

class BloodConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedHope - Blood Connect',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/register': (context) => DonorRegistration(),
        '/donors': (context) => DonorList(),
        '/request': (context) => RequestBlood(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
