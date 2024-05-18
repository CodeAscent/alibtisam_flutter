import 'package:alibtisam_flutter/helper/common/widgets/custom_dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExternalDashboard extends StatefulWidget {
  const ExternalDashboard({super.key});

  @override
  State<ExternalDashboard> createState() => _ExternalDashboardState();
}

class _ExternalDashboardState extends State<ExternalDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomDashboardCard(
                label: 'Events',
                color: Color.fromARGB(212, 139, 198, 246),
                icon: 'assets/lottie/event.json',
              ),
              CustomDashboardCard(
                label: 'Enroll Now',
                color: Color.fromARGB(211, 246, 152, 139),
                icon: 'assets/lottie/enroll.json',
              ),
              CustomDashboardCard(
                label: 'Sports',
                color: Color.fromARGB(210, 239, 246, 139),
                icon: 'assets/lottie/sports.json',
              ),
              CustomDashboardCard(
                label: 'Collection',
                color: Color.fromARGB(210, 139, 246, 157),
                icon: 'assets/lottie/collection.json',
              ),
              CustomDashboardCard(
                label: 'About',
                color: Color.fromARGB(210, 246, 139, 189),
                icon: 'assets/lottie/about.json',
              ),
            ],
          ),
        )),
      ),
    );
  }
}
