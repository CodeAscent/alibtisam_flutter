import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageSwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.language,
        color: Colors.white,
        size: 30,
      ),
      tooltip: 'switchLanguage'.tr,
      onPressed: () {
        showLanguageSwitchDialog(context);
      },
    );
  }
}

showLanguageSwitchDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('switchLanguage'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('arabic'.tr),
              leading: Radio(
                value: 'ar_DZ',
                groupValue: Get.locale?.toString(),
                onChanged: (value) {
                  _changeLanguage(value!);
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: Text('English'),
              leading: Radio(
                value: 'en_US',
                groupValue: Get.locale?.toString(),
                onChanged: (value) {
                  _changeLanguage(value!);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _changeLanguage(String locale) {
  Get.updateLocale(Locale(locale.split('_')[0], locale.split('_')[1]));
  GetStorage().write('locale', locale);
}
