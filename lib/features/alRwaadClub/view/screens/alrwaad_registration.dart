import 'package:age_calculator/age_calculator.dart';
import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/common/widgets/custom_text_field.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/features/alRwaadClub/viewModel/alrwaad_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AlrwaadRegistration extends StatefulWidget {
  const AlrwaadRegistration({super.key});

  @override
  State<AlrwaadRegistration> createState() => _AlrwaadRegistrationState();
}

class _AlrwaadRegistrationState extends State<AlrwaadRegistration> {
  final userController = Get.find<UserController>();
  final dobController = TextEditingController();
  final govtIdNumberController = TextEditingController();
  final govtIdExpirationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final alrwaadViewmodel = Get.find<AlrwaadViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Al-Rwaad Club'),
          ),
          body: alrwaadViewmodel.loading.value
              ? CustomLoader()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        kCustomListTile(
                            key: 'Name', value: userController.user!.name),
                        kCustomListTile(
                            key: 'Email', value: userController.user!.email),
                        kCustomListTile(
                            key: 'Mobile', value: userController.user!.mobile),
                        CustomTextField(
                          hintText: "YYYY-MM-DD",
                          label: dobController.text == ''
                              ? "dateOfBirth".tr
                              : "DOB* (Age : ${AgeCalculator.age(DateTime.parse(dobController.text)).years})",
                          readOnly: true,
                          suffix: IconButton(
                              color: primaryColor(),
                              onPressed: () async {
                                await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime.now())
                                    .then((value) => dobController.text =
                                        customDateFormat(value.toString()));
                                setState(() {});
                              },
                              icon: Icon(Icons.date_range)),
                          controller: dobController,
                        ),
                        CustomTextField(
                          label: 'Government Id Number',
                          controller: govtIdNumberController,
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: CustomContainerButton(
            flexibleHeight: 60,
            label: 'Submit',
            onTap: () {
              if (formKey.currentState!.validate()) {
                alrwaadViewmodel.joinAlRwaadClub(
                    govIdNumber: govtIdNumberController.text,
                    dateOfBirth: dobController.text);
              }
            },
          ),
        ),
      ),
    );
  }
}
