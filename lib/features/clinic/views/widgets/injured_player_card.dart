import 'package:alibtisam/core/services/http_wrapper.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InjuredPlayerCard extends StatelessWidget {
  final String playerId;
  final String injuryLevel;
  final String pic;
  final String name;
  final bool isAppointmentMade;
  const InjuredPlayerCard({
    super.key,
    required this.playerId,
    required this.injuryLevel,
    required this.pic,
    required this.name,
    required this.isAppointmentMade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: primaryColor())),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(130),
                  child: HttpWrapper.networkImageRequest(pic),
                ),
              ),
              Flexible(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Injury level ${injuryLevel}/5'),
              Spacer(),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                color: isAppointmentMade
                    ? Colors.green.shade200
                    : Colors.red.shade200,
                child: Text(
                  isAppointmentMade ? "VIEW APPOINTMENT" : "BOOK APPOINTMENT",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Player Id: '),
              Text(playerId),
            ],
          ),
        ],
      ),
    );
  }
}
