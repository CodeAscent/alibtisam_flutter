// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/features/tournamentRequest/view/screens/view_torunament_wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:alibtisam/features/tournamentRequest/models/tournament_model.dart';
import 'package:alibtisam/features/tournamentRequest/viewmodel/tournament_request_viewmodel.dart';
import 'package:alibtisam/core/common/widgets/player_card.dart';

class ViewTournamentDescription extends StatefulWidget {
  final String id;
  const ViewTournamentDescription({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ViewTournamentDescription> createState() =>
      _ViewTournamentDescriptionState();
}

class _ViewTournamentDescriptionState extends State<ViewTournamentDescription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) {
          tabIndex = _tabController.index;
          setState(() {});
        }
      });
  }

  bool showPlayers = true;
  @override
  Widget build(BuildContext context) {
    final tournamentRequestViewmodel = Get.find<TournamentRequestViewmodel>();
    return GetBuilder<TournamentRequestViewmodel>(
      initState: (state) {
        tournamentRequestViewmodel.viewTournamentRequests(id: widget.id);
      },
      builder: (controller) {
        final tournament = tournamentRequestViewmodel.tournament;

        return Scaffold(
          appBar: AppBar(
            title: Text('View Tournament'.tr),
            actions: [
              Visibility(
                // visible: tournament!.status == 'ACCOUNT-MANAGER-REVIEWED',
                child: IconButton(
                    onPressed: () {
                      Get.to(() =>
                              ViewTorunamentWallet(tournament: tournament!))!
                          .then((val) {
                        tournamentRequestViewmodel.viewTournamentRequests(
                            id: widget.id);
                      });
                    },
                    icon: Icon(
                      Icons.account_balance_wallet,
                      size: 35,
                    )),
              )
            ],
          ),
          body: controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        customLabelAndText('Team Name'.tr,
                            tournament!.tournamentId!.teamName!),
                        customLabelAndText(
                            'Start Date'.tr,
                            customDateFormat(
                                tournament.tournamentId!.startDate!)),
                        customLabelAndText(
                            'End Date'.tr,
                            customDateFormat(
                                tournament.tournamentId!.endDate!)),
                        customLabelAndText(
                            'status'.tr, tournament.tournamentId!.status!),
                        customLabelAndText(
                            'Type'.tr,
                            tournament.tournamentId!.type! +
                                'Tournament'.tr.toUpperCase()),
                        customLabelAndText(
                            'Location'.tr, tournament.tournamentId!.location!),
                        customLabelAndText('Description'.tr,
                            tournament.tournamentId!.description!),
                        customLabelAndText(
                            'Travel Date'.tr,
                            customDateFormat(
                                tournament.tournamentId!.travelDate!)),
                        customLabelAndText('Transport Medium'.tr,
                            tournament.tournamentId!.transportMedium!),
                        customLabelAndText(
                            'Expected Departure'.tr,
                            customDateFormat(
                                tournament.tournamentId!.expectedDeparture!)),
                        customLabelAndText(
                            'Expected Arrival'.tr,
                            customDateFormat(
                                tournament.tournamentId!.expectedArrival!)),
                        customLabelAndText(
                            'From'.tr, tournament.tournamentId!.from!),
                        customLabelAndText(
                            'To'.tr, tournament.tournamentId!.to!),
                        customLabelAndText(
                            'Location'.tr, tournament.tournamentId!.name!),
                        SizedBox(height: 30),
                        Container(
                          height: 100,
                          child: CustomTabBar(
                            tabController: _tabController,
                            customTabs: [
                              Tab(text: 'Players'.tr),
                              Tab(text: 'Coaches'.tr),
                            ],
                            tabViewScreens: [
                              Text(''),
                              Text(''),
                            ],
                          ),
                        ),
                        Visibility(
                            visible: tabIndex == 0,
                            child: Column(
                              children: List.generate(
                                  tournament.tournamentId!.playerIds!.length,
                                  (int index) {
                                UserModel player =
                                    tournament.tournamentId!.playerIds![index];
                                return PlayerCard(
                                    extraWidget: Text(
                                        '${'Age'.tr} ${AgeCalculator.age(DateTime.parse(player.dateOfBirth!)).years}'),
                                    name: player.name!,
                                    image: player.pic!,
                                    playerId: player.pId.toString());
                              }),
                            )),
                        Visibility(
                            visible: tabIndex == 1,
                            child: Column(
                              children: List.generate(
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
                            )),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
        );
      },
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
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}
