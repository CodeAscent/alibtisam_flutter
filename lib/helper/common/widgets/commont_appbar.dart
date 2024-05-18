// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RepeatedAppBar extends StatelessWidget {
  final String label;
  void Function()? fun;
  RepeatedAppBar({
    Key? key,
    required this.label,
    this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                      onPressed: fun != null
                          ? fun
                          : () {
                              Get.back();
                            },
                      icon: Icon(
                        Icons.navigate_before,
                        color: Colors.black,
                        size: 42,
                      )),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
