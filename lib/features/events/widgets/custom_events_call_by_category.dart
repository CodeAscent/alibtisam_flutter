// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/core/services/api_requests.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:alibtisam/features/events/model/events_model.dart';
import 'package:alibtisam/features/events/presentation/event_desciption.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/theme/controller/theme_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  Future generateThumbnail(String videoUrl) async {
    dynamic fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2),
              ),
              Spacer(),
              ViewEventsSheetButton(label: widget.label),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(widget.snapshot.length, (index) {
                Events event = widget.snapshot[index];

                return GestureDetector(
                  onTap: () {
                    // activePlayerController.pauseActive();
                    Get.to(() => EventDescription(
                          event: event,
                        ));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 250,
                    ),
                    child: Card(
                      elevation: 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(height: 20),
                                if (event.media[0].type == "image")
                                  Center(
                                    child: Image.network(
                                      event.media[0].url,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (event.media[0].type == "video") ...[
                                  Center(
                                    child: FutureBuilder(
                                      future:
                                          generateThumbnail(event.media[0].url),
                                      builder: (context, thumbnailSnapshot) {
                                        if (thumbnailSnapshot.hasData) {
                                          return Stack(
                                            children: [
                                              Image.file(
                                                File(thumbnailSnapshot.data
                                                    .toString()),
                                                height: 100,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              SizedBox(
                                                height: 100,
                                                child: Center(
                                                  child: IconButton.filled(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.play_circle_fill,
                                                      )),
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        return SizedBox(
                                            height: 100,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      },
                                    ),
                                  )
                                ],
                                SizedBox(height: 10),
                                Text(
                                  event.description,
                                  maxLines: 1,
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
                              ),
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
      ],
    );
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

  Future generateThumbnail(String videoUrl) async {
    dynamic fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return fileName;
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
                                      Get.to(
                                          () => EventDescription(event: event));
                                    },
                                    child: Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 220),
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
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 20),
                                                  if (event.media[0].type ==
                                                      "image")
                                                    Image.network(
                                                      event.media[0].url,
                                                      height: 100,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  if (event.media[0].type ==
                                                      "video") ...[
                                                    FutureBuilder(
                                                      future: generateThumbnail(
                                                          event.media[0].url),
                                                      builder: (context,
                                                          thumbnailSnapshot) {
                                                        if (thumbnailSnapshot
                                                            .hasData) {
                                                          return Stack(
                                                            children: [
                                                              Image.asset(
                                                                thumbnailSnapshot
                                                                    .data
                                                                    .toString(),
                                                                height: 100,
                                                                width: double
                                                                    .infinity,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              SizedBox(
                                                                height: 100,
                                                                child: Center(
                                                                  child: IconButton
                                                                      .filled(
                                                                          onPressed:
                                                                              () {},
                                                                          icon:
                                                                              Icon(
                                                                            Icons.play_circle_fill,
                                                                          )),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }
                                                        return SizedBox(
                                                            height: 100,
                                                            child: Center(
                                                                child:
                                                                    CircularProgressIndicator()));
                                                      },
                                                    )
                                                  ],
                                                  SizedBox(height: 10),
                                                  Text(
                                                    event.description,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
