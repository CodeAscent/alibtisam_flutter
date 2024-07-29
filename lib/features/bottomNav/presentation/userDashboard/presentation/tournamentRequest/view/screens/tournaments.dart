import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/view/screens/create_tournament_request.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/view/screens/view_tournament_description.dart';
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
          tournamentRequestViewmodel.fetchTournamentRequests();
        },
        builder: (controller) {
          return controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(controller.requestedTournaments.length,
                          (int index) {
                        Map<String, dynamic> data =
                            controller.requestedTournaments[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ViewTournamentDescription(
                                  id: data['_id'],
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: kAppGreyColor(),
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['tournamentId']['name']),
                                      Text('Requested By: ' +
                                          data['requestedBy']['name']),
                                      Text(
                                        'Status : ' + data['status'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: Icon(Icons.navigate_next),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => CreateTournamentRequestScreen())!.then(
              (val) => tournamentRequestViewmodel.fetchTournamentRequests());
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
