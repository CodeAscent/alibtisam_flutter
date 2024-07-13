import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/trainingPlan/view/pages/view_training_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachTrainingPlan extends StatefulWidget {
  const CoachTrainingPlan({super.key});

  @override
  State<CoachTrainingPlan> createState() => _CoachTrainingPlanState();
}

class _CoachTrainingPlanState extends State<CoachTrainingPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Training Plan'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (contex, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewTrainingPlan());
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    'Plan for 12 - 16',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  trailing: Icon(Icons.navigate_next_outlined),
                                )),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            List<dynamic> ageCategories = ['data'];
            showCupertinoDialog(
                context: context,
                builder: (context) => Material(
                      color: Colors.transparent,
                      child: CupertinoActionSheet(
                        actions: [
                          SizedBox(
                            height: 70,
                            child: CustomGradientButton(label: 'Submit'),
                          ),
                        ],
                        title: Text('Create Training Plan'),
                        message: Container(
                          height: 500,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(label: 'Plan Name'),
                                  CustomTextField(
                                    label: 'Select Age Category',
                                    suffix: DropdownButton(
                                        iconSize: 40,
                                        items: ageCategories
                                            .map((val) => DropdownMenuItem(
                                                value: val, child: Text(val)))
                                            .toList(),
                                        onChanged: (val) {
                                          setState(() {});
                                        }),
                                  ),
                                  Divider(),
                                  Text('Schedule'),
                                  CustomTextField(
                                      suffix: IconButton(
                                          onPressed: () {},
                                          icon: Icon(CupertinoIcons.calendar)),
                                      label: 'Training dates'),
                                  CustomTextField(
                                      suffix: IconButton(
                                          onPressed: () {},
                                          icon: Icon(CupertinoIcons.time)),
                                      label: 'Training times'),
                                  CustomTextField(
                                      readOnly: true,
                                      label: 'Duration of each session'),
                                  Divider(),
                                  CustomTextField(
                                      maxLines: 4, label: 'Additional notes'),
                                ]),
                          ),
                        ),
                        cancelButton: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(CupertinoIcons.xmark)),
                      ),
                    ));
          },
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                gradient: kGradientColor(),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.add,
              size: 45,
              color: Colors.white,
            ),
          ),
        ));
  }
}
