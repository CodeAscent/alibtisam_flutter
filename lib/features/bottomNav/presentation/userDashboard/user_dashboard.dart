import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/settings/models/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/controller/event_navigation.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_dashboard_card.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final eventNavigationController = Get.find<EventNavigation>();

  List<Map<String, dynamic>> dashboardItems = [
    {
      "name": "Events",
      "icon": 'assets/lottie/event.json',
      "route": "/allEvents",
      // VISIBILITY: EXTERNAL, INTERNAL AND COACH
    },
    // {
    //   "name": "Sports",
    //   "icon": 'assets/lottie/sports.json',
    //   "route": "/sports",
    //   // VISIBILITY: EXTERNAL, INTERNAL AND COACH
    // },
    //TEAM STATS , MONITERING, REPORTS
    {
      "name": "Statistics",
      "icon": 'assets/lottie/statistics.json',
      "route": "/statistics",
      // VISIBILITY: INTERNAL AND COACH
    },
    {
      "name": "Measurement \nRequests",
      "icon": 'assets/lottie/measurement.json',
      "route": "/tabBarPage",
      // VISIBILITY: COACH
    },
    // {
    //   "name": "Tournament \nRequest",
    //   "icon": 'assets/lottie/tournament.json',
    //   "route": "/tournamentRequest",
    //   // VISIBILITY: COACH
    // },
    {
      "name": "Attendance",
      "icon": 'assets/lottie/attendance.json',
      "route": "/attendance",
      // VISIBILITY: COACH AND INTERNAL
    },
    // {
    //   "name": "Practice",
    //   "icon": 'assets/lottie/practice.json',
    //   "route": "/practice",
    //   // VISIBILITY: INTERNAL
    // },
    // {
    //   "name": "Store",
    //   "icon": 'assets/lottie/store.json',
    //   "route": "/store",
    //   // VISIBILITY: COACH , INTERNAL AND EXTERNAL
    // },
    // Leave req & Certificate req
    // {
    //   "name": "Request \nPortal",
    //   "icon": 'assets/lottie/makerequest.json',
    //   "route": "/requestPortal",
    //   // VISIBILITY: COACH , INTERNAL
    // },
    // {
    //   "name": "Player \nPolarization",
    //   "icon": 'assets/lottie/polarization.json',
    //   "route": "/playerPolarization",
    //   // VISIBILITY: COACH
    // },
    // {
    //   "name": "Session \nAppointment",
    //   "icon": 'assets/lottie/appointment.json',
    //   "route": "/sessionAppointment",
    //   // VISIBILITY: INTERNAL
    // },
    // {
    //   "name": "Loan \napplication",
    //   "icon": 'assets/lottie/loan.json',
    //   "route": "/loan",
    //   // VISIBILITY: INTERNAL
    // },
    {
      "name": "Enrollment",
      "icon": 'assets/lottie/enroll.json',
      "route": "/enroll",
      // VISIBILITY: COACH, EXTERNAL AND INTERNAL
    },
    {
      "name": "Collection",
      "icon": 'assets/lottie/collection.json',
      "route": "/collection",
      // VISIBILITY: COACH, INTERNAL AND EXTERNAL
    },
  ];
  @override
  void initState() {
    super.initState();
    ApiRequests().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dashboardItems.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (dashboardItems[index]['name'] == "Events") {
                          eventNavigationController.navigatingFromSplash(false);
                        }
                        Get.toNamed(dashboardItems[index]['route'])!
                            .then((_) => ApiRequests().getUser());
                      },
                      child: CustomDashboardCard(
                        label: dashboardItems[index]['name'],
                        icon: dashboardItems[index]['icon'],
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
