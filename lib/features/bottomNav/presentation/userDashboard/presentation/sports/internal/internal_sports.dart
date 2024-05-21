import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternalSports extends StatefulWidget {
  const InternalSports({super.key});

  @override
  State<InternalSports> createState() => _InternalSportsState();
}

class _InternalSportsState extends State<InternalSports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports"),
      ),
    );
  }
}
