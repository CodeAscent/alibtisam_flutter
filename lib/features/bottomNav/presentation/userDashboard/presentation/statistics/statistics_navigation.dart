import 'package:SNP/features/bottomNav/controller/selected_player.dart';
import 'package:SNP/features/bottomNav/controller/user.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/player_statistics.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/coach_teams_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsNavigation extends StatefulWidget {
  const StatisticsNavigation({super.key});

  @override
  State<StatisticsNavigation> createState() => _StatisticsNavigationState();
}

class _StatisticsNavigationState extends State<StatisticsNavigation> {
  final userController = Get.find<UserController>();
  SelectedPlayerController selectedPlayerController =
      Get.find<SelectedPlayerController>();
  navigation() {
    if (userController.user!.role == "INTERNAL USER") {
      selectedPlayerController.updatePlayerId(userController.user!.id);
      return PlayerStatistics(
        playerId: userController.user!.id,
      );
    } else {
      return CoachTeamsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return navigation();
  }
}
