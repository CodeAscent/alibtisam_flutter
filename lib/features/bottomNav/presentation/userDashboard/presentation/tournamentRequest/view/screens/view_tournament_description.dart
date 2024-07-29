import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/models/tournament_model.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/widgets/player_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewTournamentDescription extends StatelessWidget {
  final String id;
  const ViewTournamentDescription({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final tournamentRequestViewmodel = Get.find<TournamentRequestViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('View Tournament'),
      ),
      body: GetBuilder<TournamentRequestViewmodel>(initState: (state) {
        tournamentRequestViewmodel.viewTournamentRequests(id: id);
      }, builder: (controller) {
        final tournament = tournamentRequestViewmodel.tournament;
        return controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      customLabelAndText(
                          'Team Name', tournament.tournamentId!.teamName!),
                      customLabelAndText(
                          'Start Date',
                          customDateFormat(
                              tournament.tournamentId!.startDate!)),
                      customLabelAndText('End Date',
                          customDateFormat(tournament.tournamentId!.endDate!)),
                      customLabelAndText(
                          'Statuc', tournament.tournamentId!.status!),
                      customLabelAndText(
                          'Type',
                          tournament.tournamentId!.type! +
                              ' Tournament'.toUpperCase()),
                      customLabelAndText(
                          'Location', tournament.tournamentId!.location!),
                      customLabelAndText(
                          'Description', tournament.tournamentId!.description!),
                      customLabelAndText(
                          'Travel Date',
                          customDateFormat(
                              tournament.tournamentId!.travelDate!)),
                      customLabelAndText('Transport Medium',
                          tournament.tournamentId!.transportMedium!),
                      customLabelAndText(
                          'Expected Departure',
                          customDateFormat(
                              tournament.tournamentId!.expectedDeparture!)),
                      customLabelAndText(
                          'Expected Arrival',
                          customDateFormat(
                              tournament.tournamentId!.expectedArrival!)),
                      customLabelAndText(
                          'From', tournament.tournamentId!.from!),
                      customLabelAndText('To', tournament.tournamentId!.to!),
                      customLabelAndText(
                          'Location', tournament.tournamentId!.name!),
                      Text(
                        'Players',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 22),
                      ),
                      ...List.generate(
                          tournament.tournamentId!.playerIds!.length,
                          (int index) {
                        UserModel player =
                            tournament.tournamentId!.playerIds![index];
                        return PlayerCard(
                            name: player.name!,
                            image: player.pic!,
                            playerId: player.pId.toString());
                      }),
                      SizedBox(height: 30),
                      Text(
                        'Coaches',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 22),
                      ),
                      ...List.generate(
                          tournament.tournamentId!.coachIds!.length,
                          (int index) {
                        UserModel coach =
                            tournament.tournamentId!.coachIds![index];
                        return PlayerCard(
                          isCoach: true,
                          name: coach.name!,
                          image: coach.pic!,
                          playerId: '',
                        );
                      }),
                      SizedBox(height: 60)
                    ],
                  ),
                ),
              );
      }),
    );
  }

  customLabelAndText(String key, String value) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kAppGreyColor())),
      child: Row(
        children: [
          Text(key + ":  "),
          Text(value),
        ],
      ),
    );
  }
}
