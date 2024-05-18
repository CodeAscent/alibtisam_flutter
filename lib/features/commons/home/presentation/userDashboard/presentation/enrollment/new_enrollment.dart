import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewEnrollmentScreen extends StatefulWidget {
  const NewEnrollmentScreen({super.key});

  @override
  State<NewEnrollmentScreen> createState() => _NewEnrollmentScreenState();
}

class _NewEnrollmentScreenState extends State<NewEnrollmentScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "MALE");
  TextEditingController emailController = TextEditingController();
  TextEditingController relationWithApplicantController =
      TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController correspondenceAddressController =
      TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController institutionalTypeController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController sportsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addmisionForm".tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(
                  controller: firstNameController,
                  label: "user name",
                  width: Get.width * 0.5),
              CustomTextField(
                  controller: firstNameController,
                  label: "user name",
                  width: Get.width * 0.5)
            ],
          ),
        ),
      ),
    );
  }
}
