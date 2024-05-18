import 'package:alibtisam_flutter/features/commons/events/controller/event_navigation.dart';
import 'package:alibtisam_flutter/features/commons/events/presentation/events.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_dashboard_card.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final eventNavigationController = Get.find<EventNavigation>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   // title: Text("Dashboard"),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              //ADD CALENDAR EVENT INSIDE EVENTS
              GestureDetector(
                onTap: () {
                  eventNavigationController.navigatingFromSplash(false);
                  Get.to(() => AllEvents());
                },
                child: CustomDashboardCard(
                  label: 'Events',
                  color: kStatistics(),
                  icon: 'assets/lottie/event.json',
                ),
              ),

              CustomDashboardCard(
                label: 'Sports',
                color: kStatistics(),
                icon: 'assets/lottie/sports.json',
              ),

              //TEAM STATS , MONITERING, REPORTS
              // CustomDashboardCard(
              //   label: 'Statistics',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/statistics.json',
              // ),
              // CustomDashboardCard(
              //   label: 'Attendance',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/attendance.json',
              // ),
              // CustomDashboardCard(
              //   label: 'Practice',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/practice.json',
              // ),
              // CustomDashboardCard(
              //   label: 'Make \nRequest',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/makerequest.json',
              // ),
              // CustomDashboardCard(
              //   label: 'Session \nAppointment',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/appointment.json',
              // ),
              // CustomDashboardCard(
              //   label: 'Loan \napplication',
              //   color: kStatistics(),
              //   icon: 'assets/lottie/loan.json',
              // ),
              CustomDashboardCard(
                label: 'New \nEnrollment',
                color: kStatistics(),
                icon: 'assets/lottie/enroll.json',
              ),
              CustomDashboardCard(
                label: 'Collection',
                color: kStatistics(),
                icon: 'assets/lottie/collection.json',
              ),
            ],
          ),
        )),
      ),
    );
  }
}
