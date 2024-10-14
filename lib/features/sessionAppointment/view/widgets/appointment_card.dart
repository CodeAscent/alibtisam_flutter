import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentCard extends StatelessWidget {
  final String requestedBy;
  final String date;
  final String status;
  final String description;
  const AppointmentCard({
    super.key,
    required this.requestedBy,
    required this.date,
    required this.status,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: primaryColor(),
          )),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Appointment',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          if (userController.user!.role == 'COACH')
            Text('Requested By: $requestedBy'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Status'),
                  Spacer(),
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: status == 'PENDING'
                          ? Colors.orange
                          : status == 'REJECTED'
                              ? Colors.red
                              : Colors.green,
                    ),
                  ),
                ],
              ),
              Text('Appointment On:'),
              Text(customDateTimeFormat(date)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description: ',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              Flexible(
                  child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
