import 'package:alibtisam/features/bottomNav/controller/games.dart';
import 'package:alibtisam/features/bottomNav/model/collection.dart';
import 'package:alibtisam/core/common/widgets/custom_empty_icon.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_tab_bar.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/network/api_requests.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vibration/vibration.dart';
import 'package:video_player/video_player.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with TickerProviderStateMixin {
  final gamesController = Get.find<GamesController>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    fetchData();
  }

  fetchData() async {
    await gamesController.fetchGames(date: "", stage: '');
    _tabController =
        TabController(length: gamesController.games.length, vsync: this);
  }

  TabController? _tabController;
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: GetBuilder(
        builder: (GamesController gamesController) {
          return Scaffold(
            appBar: AppBar(
              title: Text('collection'.tr),
            ),
            body: CustomTabBar(
                tabController: _tabController!,
                customTabs: gamesController.games
                    .map((tab) => Text(
                          "${tab.name.capitalize}\n${tab.stage}",
                          textAlign: TextAlign.center,
                        ))
                    .toList(),
                tabViewScreens: gamesController.games
                    .map((game) => FutureBuilder(
                          future:
                              ApiRequests().getCollectionsByGameFilter(game.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data.length == 0
                                  ? CustomEmptyWidget()
                                  : SafeArea(
                                      child: SingleChildScrollView(
                                          child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              // Spacer(),
                                              // TextButton(
                                              //     onPressed: () {
                                              //       Get.generalDialog(
                                              //         pageBuilder: (context, animation,
                                              //                 secondaryAnimation) =>
                                              //             Scaffold(),
                                              //       );
                                              //     },`
                                              //     child: Text("Filter")),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverQuiltedGridDelegate(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 4,
                                              crossAxisSpacing: 4,
                                              repeatPattern:
                                                  QuiltedGridRepeatPattern
                                                      .inverted,
                                              pattern: [
                                                QuiltedGridTile(2, 2),
                                                QuiltedGridTile(1, 1),
                                                QuiltedGridTile(1, 1),
                                                QuiltedGridTile(1, 2),
                                              ],
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Collection collection =
                                                  Collection.fromMap(
                                                      snapshot.data[index]);
                                              return GestureDetector(
                                                onTap: () {
                                                  Vibration.vibrate();
                                                  if (collection.type ==
                                                      'video') {
                                                    collection.media.play();
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              child: Container(
                                                                height: 200,
                                                                width: 200,
                                                                color:
                                                                    primaryColor(),
                                                                child: VideoPlayer(
                                                                    collection
                                                                        .media),
                                                              ),
                                                            )).then((v) =>
                                                        collection.media
                                                            .pause());
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            Dialog(
                                                              child: Container(
                                                                height: 200,
                                                                width: 200,
                                                                color:
                                                                    primaryColor(),
                                                                child: Image
                                                                    .network(
                                                                  collection
                                                                      .media,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ));
                                                  }
                                                },
                                                child: Container(
                                                  child: collection.type ==
                                                          'image'
                                                      ? Image.network(
                                                          collection.media,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Builder(
                                                          builder: (context) {
                                                          collection.media
                                                              .initialize();
                                                          return VideoPlayer(
                                                              collection.media);
                                                        }),
                                                  color: primaryColor(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ]),
                                      )),
                                    );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ))
                    .toList()),
          );
        },
      ),
    );
  }
}
