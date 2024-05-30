import 'dart:io';

import 'package:alibtisam_flutter/features/bottomNav/controller/games.dart';
import 'package:alibtisam_flutter/features/bottomNav/controller/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/model/user.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/guardian/guardian_all_forms.dart';
import 'package:alibtisam_flutter/features/bottomNav/presentation/userDashboard/presentation/enrollment/view_addmision_form.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_container_button.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:alibtisam_flutter/helper/localStorage/token_id.dart';
import 'package:alibtisam_flutter/helper/theme/app_colors.dart';
import 'package:alibtisam_flutter/helper/utils/custom_date_formatter.dart';
import 'package:alibtisam_flutter/helper/utils/custom_snackbar.dart';
import 'package:alibtisam_flutter/network/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ExternalEnrollmentForm extends StatefulWidget {
  const ExternalEnrollmentForm({super.key});

  @override
  State<ExternalEnrollmentForm> createState() => _ExternalEnrollmentFormState();
}

class _ExternalEnrollmentFormState extends State<ExternalEnrollmentForm> {
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
  TextEditingController gameController = TextEditingController();
  XFile? pic;
  XFile? idProofFront;
  XFile? idProofBack;
  XFile? certificate;
  String gameId = '';

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<dynamic> selectSports = [];
  List<dynamic> selectInstitutionalType = ["SCHOOL, ACADEMY"];
  List<String> selectRelationWithApplicant = ["SELF", "GUARDIAN"];
  List<dynamic> selectBatch = [];

  final userController = Get.find<UserController>();
  final gamesController = Get.find<GamesController>();

  @override
  void initState() {
    super.initState();
    setRelationshipIfGuardian();
    gamesController.fetchGames();
  }

  bool showRelationShipField = true;
  setRelationshipIfGuardian() {
    if (userController.user!.role == "GUARDIAN") {
      showRelationShipField = false;
      relationWithApplicantController.text = "GUARDIAN";
    } else {
      showRelationShipField = true;
    }
    setState(() {});
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
                        radius: 60,
                        backgroundColor: primaryColor(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(160),
                          child: Image.file(
                            File(pic?.path ?? ""),
                            fit: BoxFit.cover,
                            height: 155,
                            width: 155,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                color: Colors.white,
                              ); // Display an Icon on error
                            },
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  pic = await pickImageFromGalary();
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit)),
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                      readOnly: relationWithApplicantController.text == 'SELF',
                      controller: nameController,
                      label: "fullName".tr),
                  Visibility(
                    visible: showRelationShipField,
                    child: CustomTextField(
                      maxLines: 1,
                      label: "relationWithApplicant".tr,
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
                          if (val == "SELF") {
                            nameController.text = userController.user!.name;
                            emailController.text = userController.user!.email;
                            phoneController.text = userController.user!.mobile;
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  CustomTextField(
                    maxLines: 1,
                    label: "game".tr,
                    height: 50,
                    readOnly: true,
                    controller: gameController,
                    suffix: DropdownButton(
                      dropdownColor: Colors.white,
                      iconSize: 40,
                      isDense: true,
                      items: gamesController.games.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                              value.name.capitalize! + " (${value.stage})"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        gameController.text = val!.name.capitalize!;
                        gameId = val.id;
                        setState(() {});
                      },
                    ),
                  ),
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
                  CustomTextField(
                      readOnly: relationWithApplicantController.text == 'SELF',
                      controller: emailController,
                      label: "email".tr),
                  CustomTextField(
                      controller: fatherNameController, label: "fatherName".tr),
                  CustomTextField(
                      controller: motherNameController, label: "motherName".tr),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        hintText: "YYYY-MM-DD",
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
                        label: "bloodGroup".tr,
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
                        readOnly:
                            relationWithApplicantController.text == 'SELF',
                        digitsOnly: true,
                        keyboardType: TextInputType.phone,
                        label: "contact".tr,
                        width: Get.width * 0.44,
                        maxLength: 10,
                        controller: phoneController,
                      ),
                      CustomTextField(
                        label: "country".tr,
                        width: Get.width * 0.44,
                        controller: countryController,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: "city".tr,
                        width: Get.width * 0.44,
                        controller: cityController,
                      ),
                      CustomTextField(
                        label: "state".tr,
                        width: Get.width * 0.44,
                        controller: stateController,
                      ),
                    ],
                  ),
                  CustomTextField(
                    maxLines: null,
                    label: "address".tr,
                    width: Get.width,
                    controller: addressController,
                  ),
                  CustomTextField(
                    maxLines: null,
                    label: "correspondenceAddress".tr,
                    shouldValidate: false,
                    controller: correspondenceAddressController,
                  ),
                  Row(
                    children: [
                      CustomTextField(
                        digitsOnly: true,
                        keyboardType: TextInputType.number,
                        label: "postalCode".tr,
                        width: Get.width * 0.44,
                        maxLength: 8,
                        controller: postalCodeController,
                      ),
                      Spacer(),
                    ],
                  ),
                  kDocumentSection(),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    child: CustomContainerButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (pic == null ||
                              idProofFront == null ||
                              idProofBack == null) {
                            customSnackbar(
                                message: "pleasePickAllMendatoryImages".tr);
                          } else {
                            final res = await ApiRequests().createPlayerForm(
                                name: nameController.text.trim(),
                                fatherName: fatherNameController.text.trim(),
                                motherName: motherNameController.text.trim(),
                                gender: genderController.text.trim(),
                                dateOfBirth: dobController.text.trim(),
                                bloodGroup: bloodGroupController.text.trim(),
                                height: heightController.text.trim(),
                                weight: weightController.text.trim(),
                                phoneNumber: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                address: addressController.text.trim(),
                                correspondenceAddress:
                                    correspondenceAddressController.text.trim(),
                                postalCode: postalCodeController.text.trim(),
                                city: cityController.text.trim(),
                                state: stateController.text.trim(),
                                country: countryController.text.trim(),
                                relationWithApplicant:
                                    relationWithApplicantController.text ==
                                            "SELF"
                                        ? "me"
                                        : relationWithApplicantController.text,
                                idProofFrontPath: idProofFront,
                                idProofBackPath: idProofBack,
                                pic: pic,
                                certificate: certificate,
                                batch: batchController.text.trim(),
                                gameId: gameId,
                                institutionalTypes:
                                    institutionalTypeController.text.trim());
                            if (relationWithApplicantController.text ==
                                "SELF") {
                              print('-------------------->');
                              saveToken(res['token'], '');
                              UserModel? user = await ApiRequests().getUser();
                              Get.off(() => ViewAddmisionForm(
                                    player: user!,
                                  ));
                            } else {
                              if (userController.user!.role != "GUARDIAN") {
                                UserModel? user = await ApiRequests().getUser();
                                if (user!.role == "GUARDIAN") {
                                  Get.off(() => GuardianAllForms());
                                }
                              } else if (userController.user!.role ==
                                  "GUARDIAN") {
                                Get.off(() => GuardianAllForms());
                              }
                            }
                          }
                        }
                      },
                      label: "submitForm".tr,
                    ),
                  ),
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
