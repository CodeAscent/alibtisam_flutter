// ignore_for_file: deprecated_member_use

import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/features/sessionAppointment/session_appointment_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SessionBookedMessage extends StatefulWidget {
  const SessionBookedMessage({super.key});

  @override
  State<SessionBookedMessage> createState() => _SessionBookedMessageState();
}

class _SessionBookedMessageState extends State<SessionBookedMessage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Session Booked \nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              SizedBox(height: 20),
              Animate(
                effects: [FadeEffect(), ScaleEffect()],
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    CupertinoIcons.check_mark,
                    size: 70,
                    color: Colors.white,
                  ),
                ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
              ),
              SizedBox(
                width: 200,
                child: CustomContainerButton(
                  label: 'Go Back',
                  onTap: () {
                    Get.to(() => SessionAppointmentNavigation());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
