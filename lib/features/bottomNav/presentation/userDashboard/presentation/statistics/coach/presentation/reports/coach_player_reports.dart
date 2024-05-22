import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CoachPlayerReports extends StatefulWidget {
  const CoachPlayerReports({super.key});

  @override
  State<CoachPlayerReports> createState() => _CoachPlayerReportsState();
}

class _CoachPlayerReportsState extends State<CoachPlayerReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: kAppGreyColor(),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                onTap: () {},
                title: Text("Player ID :123456"),
                subtitle: Text("Reported On : 10/10/2023"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
