import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerCard extends StatelessWidget {
  final String name;
  final String image;
  final String playerId;
  final bool? showArrow;
  final Widget? extraWidget;
  final bool? selected;
  final bool? isCoach;
  const PlayerCard(
      {required this.name,
      required this.image,
      required this.playerId,
      this.showArrow = true,
      this.extraWidget,
      this.selected = false,
      this.isCoach = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: selected! ? Colors.blue.shade100 : null,
          border: Border.all(color: kAppGreyColor()),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(160),
            child: Image.network(
              image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  name.capitalize!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                if (!isCoach!) Text('Player Id: $playerId'),
                if (extraWidget != null) extraWidget!,
              ],
            ),
          ),
          if (showArrow!)
            SizedBox(
              width: 60,
              child: Icon(
                Icons.navigate_next,
                size: 35,
              ),
            ),
        ],
      ),
    );
  }
}
