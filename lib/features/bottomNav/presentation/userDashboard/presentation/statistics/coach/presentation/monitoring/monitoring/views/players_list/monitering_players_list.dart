
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MoniteringPlayersList extends StatefulWidget {
  const MoniteringPlayersList({super.key,});

  @override
  State<MoniteringPlayersList> createState() => _MoniteringPlayersListState();
}

class _MoniteringPlayersListState extends State<MoniteringPlayersList> {
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("players".tr),
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Column()
        // FutureBuilder(
        //   future: AppApi()
        //       .getPlayersByTeamId(teamId: widget.teamsModel.id.toString()),
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //     if (snapshot.hasData) {
        //       return SingleChildScrollView(
        //         child: Column(
        //           children: List.generate(snapshot.data.length, (index) {
        //             final data = snapshot.data[index];
        //             return Card(
        //               color: Colors.white,
        //               surfaceTintColor: Colors.white,
        //               child: SizedBox(
        //                 height: 85,
        //                 child: Column(
        //                   children: [
        //                     SizedBox(height: 10),
        //                     ListTile(
        //                       onTap: () {
        //                         HttpWrapper.dummyLoading();
        //                         Get.to(() => CoachMonitering(
        //                               player: snapshot.data[index],
        //                             ));
        //                       },
        //                       title: Text(
        //                         data["name"],
        //                         maxLines: 1,
        //                         overflow: TextOverflow.ellipsis,
        //                       ),
        //                       subtitle: Text(
        //                           "playerId".tr + data["playerId"].toString()),
        //                       trailing: Icon(Icons.navigate_next),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           }),
        //         ),
        //       );
        //     } else {
        //       return SizedBox();
        //     }
        //   },
        // ),
      ),
    );
  }
}
