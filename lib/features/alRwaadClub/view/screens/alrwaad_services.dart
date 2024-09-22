import 'dart:math';

import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/alRwaadClub/models/alRwaad_plans.dart';
import 'package:alibtisam/features/alRwaadClub/models/alRwaad_service.dart';
import 'package:alibtisam/features/alRwaadClub/view/screens/alrwaad_registration.dart';
import 'package:alibtisam/features/alRwaadClub/view/screens/view_alrwaad_plan.dart';
import 'package:alibtisam/features/alRwaadClub/viewModel/alrwaad_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlrwaadServices extends StatefulWidget {
  @override
  State<AlrwaadServices> createState() => _AlrwaadServicesState();
}

class _AlrwaadServicesState extends State<AlrwaadServices> {
  final List<String> quotes = [
    "Age is merely the number of years the world has been enjoying you. Stay active, stay young.",
    "The best investment you can make is in your health.",
    "It’s never too late to take charge of your well-being.",
    "Fitness is not about being better than someone else.",
    "Your health is your wealth.",
    "Movement is the essence of life. Embrace each day with energy and vitality.",
    "You are never too old to set another goal or to dream a new dream.",
    "Strong body, strong mind, strong life.",
  ];

  final alrwaadViewmodel = Get.find<AlrwaadViewmodel>();
  final userController = Get.find<UserController>();
  String selectedPlan = '';
  @override
  Widget build(BuildContext context) {
    final String selectedQuote =
        quotes[Random().nextInt(quotes.length)]; // Pick a random quote

    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Al-Rwaad Services',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          // backgroundColor: Color(0xFFE73725), // Your primary color
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: kGradientColor(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: FutureBuilder(
              future: alrwaadViewmodel.getAllServices(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          selectedQuote,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              AlRwaadService service = snapshot.data![index];
                              return _buildServiceCard(service);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
        bottomNavigationBar: Visibility(
          replacement: CustomGradientButton(
            label: 'Current Plan',
            onTap: () {
              Get.to(() => ViewAlrwaadPlan());
            },
          ),
          visible: !controller.user!.isSubscriptionActive!,
          child: CustomContainerButton(
            onTap: () {
              if (controller.user!.role! == 'ALRWAAD USER') {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return CupertinoAlertDialog(
                        title: Text(
                          'Select Plan',
                          style: TextStyle(fontSize: 22),
                        ),
                        content: SizedBox(
                          height: 400,
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: alrwaadViewmodel.getPlans(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        AlrwaadPlan plan = snapshot.data[index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedPlan = plan.planName!;
                                            });
                                          },
                                          child: kCustomListTile(
                                              selected: selectedPlan ==
                                                  plan.planName!,
                                              key: plan.planName.toString(),
                                              value: 'Price ~' +
                                                  plan.price.toString()),
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () async {
                                if (selectedPlan != '') {
                                  await alrwaadViewmodel.subscribe(
                                      plan: selectedPlan);
                                } else {
                                  customSnackbar(
                                      'Please select a plan', ContentType.help);
                                }
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      );
                    });
                  },
                );
              } else {
                Get.to(() => AlrwaadRegistration());
              }
            },
            flexibleHeight: 60,
            label: controller.user!.role! == 'ALRWAAD USER'
                ? 'Select Plan'
                : 'Subscribe Now',
          ),
        ),
      );
    });
  }

  Widget _buildServiceCard(AlRwaadService service) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          // Background card with rounded corners
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                service.icon!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Service info
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (service.arabicName!.isNotEmpty)
                      Text(
                        service.arabicName!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
