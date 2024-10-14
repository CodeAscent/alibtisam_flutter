// import 'package:alibtisam/core/theme/app_colors.dart';
// import 'package:flutter/material.dart';

// class PopUpMenuTile extends StatelessWidget {
//   const PopUpMenuTile(
//       {Key key,
//       @required this.icon,
//       @required this.title,
//       this.isActive = false})
//       : super(key: key);
//   final IconData icon;
//   final String title;
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Icon(icon,
//             color: isActive
//                 ? kprimaryColor()
//                 : Theme.of(context).primaryColor),
//         const SizedBox(
//           width: 8,
//         ),
//         Text(
//           title,
//           style: TextStyle(
//               color: isActive
//                   ? Theme.of(context).primaryColor
//                   : kAppGreyColor()),
//         ),
//       ],
//     );
//   }
// }
