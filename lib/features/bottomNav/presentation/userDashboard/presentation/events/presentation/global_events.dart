import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/widgets/custom_events_call_by_category.dart';
import 'package:SNP/helper/common/widgets/custom_empty_icon.dart';
import 'package:SNP/helper/common/widgets/custom_loading.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
            ApiRequests().allEvents("SPORT EVENT"),
            ApiRequests().allEvents("GENERAL EVENT")
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data![0].length == 0 &&
                      snapshot.data![0].length == 0 &&
                      snapshot.data![0].length == 0
                  ? CustomEmptyWidget()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (snapshot.data![0].length != 0)
                            CustomEventsCallByCategory(
                              label: 'announcementEvent'.tr,
                              snapshot: snapshot.data![0],
                            ),
                          if (snapshot.data![1].length != 0)
                            CustomEventsCallByCategory(
                              label: 'sportEvent'.tr,
                              snapshot: snapshot.data![1],
                            ),
                          if (snapshot.data![2].length != 0)
                            CustomEventsCallByCategory(
                              label: 'GENERAL EVENT'.tr,
                              snapshot: snapshot.data![2],
                            ),
                        ],
                      ),
                    );
            }
            return SizedBox();
          }),
    );
  }
}
