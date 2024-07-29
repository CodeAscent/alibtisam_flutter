import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/view/screens/create_tournament_request.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TournamentsScreen extends StatefulWidget {
  const TournamentsScreen({super.key});

  @override
  State<TournamentsScreen> createState() => _TournamentsScreenState();
}

class _TournamentsScreenState extends State<TournamentsScreen> {
  final tournamentRequestViewmodel = Get.find<TournamentRequestViewmodel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tournament Request'),
      ),
      body: GetBuilder<TournamentRequestViewmodel>(
        initState: (state) {
            
        },
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [],
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => CreateTournamentRequestScreen());
        },
        child: CircleAvatar(
          backgroundColor: primaryColor(),
          radius: 30,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
