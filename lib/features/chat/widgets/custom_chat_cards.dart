import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomChatCards extends StatelessWidget {
  const CustomChatCards({
    super.key,
    required this.label,
    required this.lastMessage,
    required this.time,
    required this.image,
  });
  final String label;
  final String lastMessage;
  final String time;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        height: 100,
        margin: EdgeInsets.all(2),
        color: kAppGreyColor(),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(160),
              child: Image.network(
                image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
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
      ),
    );
  }
}
