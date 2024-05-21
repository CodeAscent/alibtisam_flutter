import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeasurementRequest extends StatefulWidget {
  const MeasurementRequest({super.key});

  @override
  State<MeasurementRequest> createState() => _MeasurementRequestState();
}

class _MeasurementRequestState extends State<MeasurementRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Request Page"),),
    );
  }
}