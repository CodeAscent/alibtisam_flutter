// import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_manager.dart';
// import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/events/widgets/feedPlayer/multiManager/feed_multi_player.dart';
// import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';


// class ShortVideoPlayer extends StatefulWidget {
//   const ShortVideoPlayer({Key? key}) : super(key: key);

//   @override
//   ShortVideoPlayerState createState() => ShortVideoPlayerState();
// }

// class ShortVideoPlayerState extends State<ShortVideoPlayer> {

//   late FlickMultiManager flickMultiManager;

//   @override
//   void initState() {
//     super.initState();
//     flickMultiManager = FlickMultiManager();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return 
//     VisibilityDetector(
//       key: ObjectKey(flickMultiManager),
//       onVisibilityChanged: (visibility) {
//         if (visibility.visibleFraction == 0 && mounted) {
//           flickMultiManager.pause();
//         }
//       },
//       child: PageView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Container(
//               height: 800,
//               margin: const EdgeInsets.all(2),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: FlickMultiPlayer(
//                   url: items[index],
//                   flickMultiManager: flickMultiManager,
//                   image: shortVideoMockData['items'][index]['image'],
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }