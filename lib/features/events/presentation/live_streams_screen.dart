import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/events/model/events_model.dart';
import 'package:alibtisam/features/events/presentation/view_live_stream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveStreamButton extends StatefulWidget {
  const LiveStreamButton({
    super.key,
  });

  @override
  State<LiveStreamButton> createState() => _LiveStreamButtonState();
}

class _LiveStreamButtonState extends State<LiveStreamButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiRequests().allEvents('LIVE STREAM'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => LiveStreamsScreen(snapshot: snapshot.data!));
                },
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: primaryColor(),
                  child: Image.asset('assets/images/live.gif'),
                ),
              );
            }
          }
          return SizedBox();
        });
  }
}

class LiveStreamsScreen extends StatelessWidget {
  final List<Events> snapshot;
  const LiveStreamsScreen({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
          final event = snapshot[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => ViewLiveStream(
                    event: event,
                  ));
            },
            child: Card(
              elevation: 2, // Adjust elevation as needed
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Category: ${event.category}',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Date & Time: ${customDateTimeFormat(event.dateTime)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Location: ${event.location}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Description: ${event.description}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
