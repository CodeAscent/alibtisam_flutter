import 'package:alibtisam_flutter/features/commons/events/widgets/custom_events_call_by_category.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';

class GlobalEvents extends StatelessWidget {
  const GlobalEvents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          ApiRequests().allEvents("ANNOUNCEMENT EVENT"),
          ApiRequests().allEvents("SPORT EVENT")
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  CustomEventsCallByCategory(
                    label: 'ANNOUNCEMENT EVENT',
                    snapshot: snapshot.data![0],
                  ),
                  CustomEventsCallByCategory(
                    label: 'SPORTS EVENT',
                    snapshot: snapshot.data![1],
                  ),
                ],
              )),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
