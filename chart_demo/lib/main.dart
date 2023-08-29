import 'dart:async';
import 'dart:math';
import 'package:chart_demo/barchart2.dart';
import 'package:chart_demo/dashboard_demo.dart';
import 'package:chart_demo/mychart.dart';
import 'package:chart_demo/pie_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_chart1.dart';
import 'mychart2.dart';
import 'package:timezone/data/latest.dart' as tz;

void main(){
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }


  Future<void> setup() async {
    await tz.initializeTimeZones();
   /* var detroit = tz.get
    var now = tz.TZDateTime.now(detroit);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: MyChart2(),
        ),
      ),
    );
  }
}



