import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/presentation/event_desciption.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/feed_player.dart';
import 'package:SNP/helper/common/widgets/custom_pod_player.dart';
import 'package:SNP/helper/theme/app_colors.dart';
import 'package:SNP/helper/utils/loading_manager.dart';
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
    return Column(children: [
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
                  // activePlayerController.pauseActive();
                  Get.to(() => EventDescription(
                        event: event,
                      ));
                },
                child: Container(
                  height: 250,
                  width: 200,
                  child: Card(
                    elevation: 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          if (event.media[0].type == "video") ...[
                            Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: primaryColor(),
                                size: 100,
                              ),
                            ),
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
