import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ViewAlrwaadPlan extends StatefulWidget {
  const ViewAlrwaadPlan({super.key});

  @override
  State<ViewAlrwaadPlan> createState() => _ViewAlrwaadPlanState();
}

class _ViewAlrwaadPlanState extends State<ViewAlrwaadPlan> {
  final userController = Get.find<UserController>();
  @override
  void initState() {
    super.initState();
    userController.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = userController.user!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before,
              size: 35,
              color: Colors.white,
            )),
        title: const Text(
          'My Subscription',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor(),
      ),
      body: Obx(
        () => userController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile Section
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Subscription Details Section
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subscription Status: ${user.isSubscribed! ? 'Subscribed' : 'Not Subscribed'}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Plan Active Status: ${user.isSubscriptionActive! ? 'Yes' : 'No'}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Plan: ${user.plan}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Subscription Start: ${customDateFormat(user.subscriptionStart!)}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Subscription End: ${customDateFormat(user.subscriptionEnds!)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // General Info Section
                    Text(
                      'General Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Age: ${AgeCalculator.age(DateTime.parse(user.dateOfBirth!)).years}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Date of Birth: ${customDateFormat(user.dateOfBirth!)}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Gov ID Number: ${user.govIdNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}
