import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/clinic/models/injured_player_model.dart';
import 'package:alibtisam/features/clinic/repo/injured_player_repo.dart';
import 'package:alibtisam/features/clinic/viewmodel/injured_player_viewmodel.dart';
import 'package:alibtisam/features/clinic/views/screens/injured_player_details.dart';
import 'package:alibtisam/features/clinic/views/screens/view_appointment_date.dart';
import 'package:alibtisam/features/clinic/views/widgets/injured_player_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachClinicTabs extends StatelessWidget {
  const CoachClinicTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return InjuredPlayersList();
  }
}

class InjuredPlayersList extends StatefulWidget {
  const InjuredPlayersList({
    super.key,
  });

  @override
  State<InjuredPlayersList> createState() => _InjuredPlayersListState();
}

class _InjuredPlayersListState extends State<InjuredPlayersList> {
  final injuredPlayerViewmodel =
      InjuredPlayerViewmodel(injuredPlayerRepo: InjuredPlayerRepo());
  List<InjuredPlayerModel> injuredPlayers = [];
  fetchInjuredPlayers() async {
    injuredPlayers = await injuredPlayerViewmodel.getInjuredPlayers();
    return injuredPlayers;
  }

  refresh() {
    fetchInjuredPlayers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Players'),
        ),
        body: FutureBuilder(
          future: fetchInjuredPlayers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: ListView.builder(
                  itemCount: injuredPlayers.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    InjuredPlayerModel player = injuredPlayers[index];

                    return InkWell(
                      onTap: () {
                        if (player.isAppointmentMade == true) {
                          Get.to(() => ViewAppointmentDetails(
                                    userId: player.userId!,
                                  ))!
                              .then((val) {
                            refresh();
                          });
                        } else {
                          Get.to(() => InjuredPlayerDetailsForm(
                                    playerData: player,
                                  ))!
                              .then((val) {
                            refresh();
                          });
                        }
                      },
                      child: InjuredPlayerCard(
                        name: player.name.toString(),
                        injuryLevel: player.readiness!.injury.toString(),
                        playerId: player.pId.toString(),
                        pic: player.pic.toString(),
                        isAppointmentMade: player.isAppointmentMade!,
                      ),
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

////////////
class InjuredPlayersAppointments extends StatelessWidget {
  const InjuredPlayersAppointments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('appointments'),
    );
  }
}
