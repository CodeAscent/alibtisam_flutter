import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/events/widgets/custom_events_call_by_category.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalEvents extends StatelessWidget {
  const GlobalEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: FutureBuilder(
          future: Future.wait([
            ApiRequests().allEvents("ANNOUNCEMENT EVENT"),
            ApiRequests().allEvents("SPORT EVENT")
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomEventsCallByCategory(
                      label: 'announcementEvent'.tr,
                      snapshot: snapshot.data![0],
                    ),
                    CustomEventsCallByCategory(
                      label: 'sportEvent'.tr,
                      snapshot: snapshot.data![1],
                    ),
                    CustomEventsCallByCategory(
                      label: 'sportEvent'.tr,
                      snapshot: snapshot.data![1],
                    ),
                    CustomEventsCallByCategory(
                      label: 'sportEvent'.tr,
                      snapshot: snapshot.data![1],
                    ),
                  ],
                ),
              );
            }
            return Center();
          }),
    );
  }
}
