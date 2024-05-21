import 'dart:io';

import 'package:alibtisam_flutter/helper/common/widgets/custom_container_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class NewEnrollmentScreen extends StatefulWidget {
  const NewEnrollmentScreen({super.key});

  @override
  State<NewEnrollmentScreen> createState() => _NewEnrollmentScreenState();
}

class _NewEnrollmentScreenState extends State<NewEnrollmentScreen> {
  TextEditingController nameController = TextEditingController();
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
  XFile? photo;
  XFile? idProofFront;
  XFile? idProofBack;
  XFile? certificate;
  String gameId = '';

  bool canCheckSchool = false;
  bool canCheckAcademy = false;
  bool showInstitution = false;
  bool showbatchSelection = false;
  bool isLoading = false;

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<dynamic> selectSports = [];
  List<dynamic> selectInstitutionalType = ["SCHOOL, ACADEMY"];
  List<String> selectRelationWithApplicant = ["SELF", "GUARDIAN"];
  List<dynamic> selectBatch = [];
  setDefaults() {
    showInstitution = true;
    canCheckAcademy = false;
    canCheckSchool = false;
    batchController.clear();
    selectBatch.clear();
    showbatchSelection = false;
  }

  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text("addmisionForm".tr),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryColor().withOpacity(0.6),
                        radius: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000),
                          child: SizedBox(
                            width: 120,
                            child: Image.file(
                              File(photo?.path ?? ""),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ); // Display an Icon on error
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  photo = await pickImageFromGalary();
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit)),
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                      controller: nameController, label: "Full name"),
                  SizedBox(height: 10),
                  Center(
                    child: GenderPickerWithImage(
                      verticalAlignedText: false,
                      selectedGender: Gender.Male,
                      selectedGenderTextStyle: TextStyle(
                          color: primaryColor(), fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        genderController.text =
                            gender.toString().split(".")[1].toUpperCase();
                        // setState(() {});
                      },
                      //equallyAligned: false,
                      animationDuration: Duration(milliseconds: 600),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.3,
                      padding: const EdgeInsets.all(3),
                      size: 50, //default : 40
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextField(controller: emailController, label: "Email"),
                  CustomTextField(
                      controller: fatherNameController, label: "Father's name"),
                  CustomTextField(
                      controller: motherNameController, label: "Mother's name"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: "DOB*",
                        width: Get.width * 0.44,
                        height: 60,
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
                            },
                            icon: Icon(Icons.date_range)),
                        controller: dobController,
                      ),
                      //BLOOD GROUP
                      CustomTextField(
                        maxLines: 1,
                        label: "Blood Group*",
                        width: Get.width * 0.44,
                        height: 60,
                        readOnly: true,
                        controller: bloodGroupController,
                        suffix: DropdownButton(
                          iconSize: 40,
                          isDense: true,
                          items: bloodGroups.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (val) {
                            bloodGroupController.text = val ?? '';
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: "Height (ft)*",
                        width: Get.width * 0.44,
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: heightController,
                      ),
                      CustomTextField(
                        label: "Weight (kg)*",
                        width: Get.width * 0.44,
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        controller: weightController,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.phone,
                        label: "Contact*",
                        width: Get.width * 0.44,
                        maxLength: 10,
                        controller: phoneController,
                      ),
                      CustomTextField(
                        label: "Country*",
                        width: Get.width * 0.44,
                        controller: countryController,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: "City*",
                        width: Get.width * 0.44,
                        controller: cityController,
                      ),
                      CustomTextField(
                        label: "State*",
                        width: Get.width * 0.44,
                        controller: stateController,
                      ),
                    ],
                  ),
                  CustomTextField(
                    maxLines: null,
                    label: "Address*",
                    width: Get.width,
                    controller: addressController,
                  ),
                  CustomTextField(
                    maxLines: null,
                    label: "Correspondence Address",
                    shouldValidate: false,
                    controller: correspondenceAddressController,
                  ),
                  Row(
                    children: [
                      CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        label: "Postal Code*",
                        width: Get.width * 0.44,
                        maxLength: 8,
                        controller: postalCodeController,
                      ),
                      Spacer(),
                    ],
                  ),
                  CustomTextField(
                    maxLines: 1,
                    label: "Relation with applicant*",
                    height: 60,
                    readOnly: true,
                    controller: relationWithApplicantController,
                    suffix: DropdownButton(
                      dropdownColor: Colors.white,
                      iconSize: 40,
                      isDense: true,
                      items: selectRelationWithApplicant.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        relationWithApplicantController.text = val ?? '';
                        setState(() {});
                      },
                    ),
                  ),
                  kDocumentSection(),
                  SizedBox(height: 20),
                  CustomContainerButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (photo == null ||
                            idProofFront == null ||
                            idProofBack == null) {
                          customSnackbar(
                              message: "Please pick all mendatory images");
                        }
                      }
                    },
                    label: "Submit Form",
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column kDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Id Proof",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () async {
                  idProofFront = await pickImageFromGalary();
                  setState(() {});
                },
                child: kRepeatedImageBox(
                    image: idProofFront?.path ?? '', label: "Front")),
            SizedBox(width: 30),
            GestureDetector(
                onTap: () async {
                  idProofBack = await pickImageFromGalary();
                  setState(() {});
                },
                child: kRepeatedImageBox(
                    image: idProofBack?.path ?? '', label: "Back")),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Upload Certificate",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            certificate = await pickImageFromGalary();
            setState(() {});
          },
          child: kRepeatedImageBox(
              image: certificate?.path ?? '', label: "(Optional)"),
        ),
      ],
    );
  }

  Column kRepeatedImageBox({required String image, required String label}) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: image == ''
              ? Icon(Icons.arrow_downward)
              : Image.file(
                  File(image),
                  fit: BoxFit.cover,
                ),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5)),
        ),
        Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 2,
              color: Colors.grey.shade600),
        )
      ],
    );
  }
}

Future<XFile?> pickImageFromGalary() async {
  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image;
}
