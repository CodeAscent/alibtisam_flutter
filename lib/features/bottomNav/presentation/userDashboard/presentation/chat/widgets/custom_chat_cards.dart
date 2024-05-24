import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChatCards extends StatelessWidget {
  const CustomChatCards({
    super.key,
    required this.label,
    required this.lastMessage,
    required this.time,
  });
  final String label;
  final String lastMessage;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      height: 100,
      margin: EdgeInsets.all(2),
      color: kAppGreyColor(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label),
                Text(
                  lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(time),
        ],
      ),
    );
  }
}
