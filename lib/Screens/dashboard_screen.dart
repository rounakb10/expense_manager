import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\tDashboard',
          style: TextStyle(fontSize: 24),
        ),
        // centerTitle: true,
      ),
      body: Scaffold(
        body: Center(),
      ),
    );
  }
}
