// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:SNP/features/bottomNav/controller/date_range.dart';
import 'package:SNP/core/utils/custom_date_formatter.dart';
import 'package:SNP/network/api_requests.dart';
import 'package:SNP/network/api_urls.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/controller/active_player.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/model/events_model.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/presentation/event_desciption.dart';
import 'package:SNP/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/feed_player.dart';
import 'package:SNP/core/common/widgets/custom_pod_player.dart';
import 'package:SNP/core/theme/app_colors.dart';
import 'package:SNP/core/theme/controller/theme_controller.dart';
import 'package:SNP/core/utils/loading_manager.dart';
import 'package:lottie/lottie.dart';

class CustomEventsCallByCategory extends StatefulWidget {
  final String label;
  final List<Events> snapshot;

  const CustomEventsCallByCategory({
    Key? key,
    required this.label,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<CustomEventsCallByCategory> createState() =>
      _CustomEventsCallByCategoryState();
}

class _CustomEventsCallByCategoryState
    extends State<CustomEventsCallByCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              widget.label,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 2),
            ),
            Spacer(),
            ViewEventsSheetButton(label: widget.label),
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(widget.snapshot.length, (index) {
              Events event = widget.snapshot[index];

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
                      child: Stack(
                        children: [
                          Column(
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
                                  width: double.infinity,
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
                          Positioned(
                              top: 5,
                              right: 0,
                              child: Visibility(
                                visible: event.isNew,
                                child: LottieBuilder.asset(
                                  'assets/lottie/new_event.json',
                                  height: 50,
                                ),
                              ))
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

class ViewEventsSheetButton extends StatefulWidget {
  final String label;
  const ViewEventsSheetButton({super.key, required this.label});

  @override
  State<ViewEventsSheetButton> createState() => _ViewEventsSheetButtonState();
}

class _ViewEventsSheetButtonState extends State<ViewEventsSheetButton> {
  List<DateTime?>? dates = [];
  late Future<List<Events>> eventsFuture;

  @override
  void initState() {
    super.initState();
    eventsFuture = fetchEvent();
  }

  Future<List<Events>> fetchEvent() async {
    final res = await ApiRequests().allEventsWithDateFilter(
      widget.label,
      dates!.isEmpty ? '' : customDateFormat(dates![0].toString()),
      dates!.length < 2 ? '' : customDateFormat(dates![1].toString()),
    );

    print('Fetched events: $res');
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          eventsFuture = fetchEvent();
        });

        showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return BottomSheet(
                  showDragHandle: true,
                  builder: (BuildContext context) {
                    return FutureBuilder<List<Events>>(
                      future: eventsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('No events found.'),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      dates!.clear();
                                      eventsFuture = fetchEvent();
                                    });
                                  },
                                  child: Text("Clear Filters"))
                            ],
                          ));
                        }

                        final events = snapshot.data!;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      "DATE FILTER",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        ThemeController themeController =
                                            Get.find<ThemeController>();
                                        dates =
                                            await showCalendarDatePicker2Dialog(
                                          context: context,
                                          config:
                                              CalendarDatePicker2WithActionButtonsConfig(
                                            controlsTextStyle: TextStyle(
                                                color: primaryColor()),
                                            weekdayLabelTextStyle: TextStyle(
                                                color: primaryColor()),
                                            yearTextStyle: TextStyle(
                                                color: themeController
                                                            .liveTheme.value ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Colors.black),
                                            monthTextStyle: TextStyle(
                                                color: themeController
                                                            .liveTheme.value ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Colors.black),
                                            dayTextStyle: TextStyle(
                                                color: themeController
                                                            .liveTheme.value ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Colors.black),
                                            calendarType:
                                                CalendarDatePicker2Type.range,
                                          ),
                                          dialogSize: Size.fromHeight(400),
                                        );

                                        setState(() {
                                          if (dates == null) {
                                            dates = [];
                                          }
                                          eventsFuture = fetchEvent();
                                        });
                                      },
                                      icon: Icon(Icons.calendar_month),
                                    ),
                                    Spacer(),
                                    if (dates!.isNotEmpty) ...[
                                      Text(customDateFormat(
                                              dates![0].toString()) +
                                          " - " +
                                          customDateFormat(
                                              dates![1].toString())),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              dates!.clear();
                                              eventsFuture = fetchEvent();
                                            });
                                          },
                                          icon: Icon(Icons.clear))
                                    ]
                                  ],
                                ),
                              ),
                              SizedBox(height: 40),
                              GridView.builder(
                                itemCount: events.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 250,
                                  maxCrossAxisExtent: 220,
                                ),
                                itemBuilder: (context, index) {
                                  final event = events[index];
                                  return GestureDetector(
                                    onTap: () {
                                      LoadingManager.dummyLoading();
                                      Get.to(
                                          () => EventDescription(event: event));
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              if (event.media[0].type ==
                                                  "image")
                                                Image.network(
                                                  event.media[0].url,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              if (event.media[0].type ==
                                                  "video")
                                                Center(
                                                  child: Icon(
                                                    Icons.play_circle_fill,
                                                    color: primaryColor(),
                                                    size: 100,
                                                  ),
                                                ),
                                              SizedBox(height: 10),
                                              Text(
                                                event.description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  onClosing: () {},
                );
              },
            );
          },
        ).then((val) {
          setState(() {
            dates!.clear();
          });
        });
      },
      icon: Icon(Icons.filter_alt_outlined),
    );
  }
}
