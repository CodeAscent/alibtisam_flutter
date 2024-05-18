import 'package:flutter/material.dart';

class LogoAndArabicText extends StatelessWidget {
  const LogoAndArabicText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(160),
          child: Image.asset(
            'assets/images/launcher_icon.png',
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(height: 10),
        Text('AL-IBTISAM'),
        Text('نادي الابتسام السعودي')
      ],
    );
  }
}
