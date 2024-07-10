import 'package:alibtisam/core/common/widgets/custom_gradient_button.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  final String whatsappNumber =
      "+966542222898"; // Replace with your WhatsApp number
  final String whatsappMessage =
      "Hello, I need help with..."; // Pre-filled message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("help&support".tr),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "wereHereToHelp".tr,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "ifYouHaveAnyQuestion".tr,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse(
                      "https://forms.zohopublic.in/harshsinghsaluja10/form/newform/formperma/CQHk6paEPuPa6gspvdGjBfGVhE7q7kIKBCS8Xm14i7s"));
                },
                child: _buildSupportCard(
                  icon: Icons.question_answer,
                  title: "zohoForm".tr,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchWhatsApp();
                },
                child: _buildSupportCard(
                  icon: Icons.chat,
                  title: "contactUsOnWhatsapp".tr,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse("mailto:info@alibtisam.club"));
                },
                child: _buildSupportCard(
                  icon: Icons.email,
                  title: "emailUs".tr,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('Alert!'),
                      content: Text(
                          "Are you sure your want to request for account deletion?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                              customSnackbar(
                                  message:
                                      "Account deletion request has been made successfully, your account will be deleted within 48 hours");
                            },
                            child: Text('Yes',
                                style: TextStyle(color: Colors.red))),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                  );
                },
                child: _buildSupportCard(
                  icon: Icons.emoji_nature,
                  title: "Delete Account".tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    IconData? icon,
    required String title,
  }) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          gradient: kGradientColor(), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: ListTile(
          leading: Icon(icon, color: Colors.white, size: 36),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp() async {
    final whatsappUrl =
        "https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(whatsappMessage)}";
    launchUrl(Uri.parse(whatsappUrl));
  }
}
