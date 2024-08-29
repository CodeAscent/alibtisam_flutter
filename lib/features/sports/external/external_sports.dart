import 'package:flutter/material.dart';

class ExternalSports extends StatefulWidget {
  const ExternalSports({super.key});

  @override
  State<ExternalSports> createState() => _ExternalSportsState();
}

class _ExternalSportsState extends State<ExternalSports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports"),
      ),
    );
  }
}
