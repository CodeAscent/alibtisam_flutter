import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerCard extends StatelessWidget {
  final String name;
  final String image;
  final String playerId;
  final bool? showArrow;
  final Widget? extraWidget;
  const PlayerCard(
      {required this.name,
      required this.image,
      required this.playerId,
      this.showArrow = true,
      this.extraWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(name.capitalize!),
                Text('Player Id: $playerId'),
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
