import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/presentation/event_desciption.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_pod_player.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomEventsCallByCategory extends StatelessWidget {
  final String label;
  final List<Events> snapshot;

  const CustomEventsCallByCategory({
    super.key,
    required this.label,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    final activePlayerController = Get.find<ActivePlayerController>();

    return Column(children: [
      SizedBox(height: 20),
      Text(
        label,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 2),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(snapshot.length, (index) {
              Events event = snapshot[index];

              return GestureDetector(
                onTap: () {
                  LoadingManager.dummyLoading();
                  activePlayerController.pauseActive();
                  Get.to(() => EventDescription(
                        event: event,
                      ));
                },
                child: Container(
                  height: 370,
                  width: 180,
                  child: Card(
                    elevation: 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          if (event.media[0].type == "image")
                            Image.network(
                              event.media[0].url,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          if (event.media[0].type == "video") ...[
                            Container(
                                height: 250,
                                child: CustomPodPlayer(url: event.media[0].url))
                          ],
                          SizedBox(height: 10),
                          Text(
                            event.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
      Divider(),
    ]);
  }
}
