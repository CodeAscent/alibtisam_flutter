// ignore: must_be_immutable
import 'package:SNP/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSlider extends StatefulWidget {
  num value;
  final bool canChange;
  final String label;
  final Color? color;
  final void Function(double)? onChanged;
  CustomSlider(
      {super.key,
      required this.value,
      required this.label,
      required this.canChange,
      this.color,
      this.onChanged});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  widget.value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: widget.value.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            activeColor: primaryColor(),
            label: "${widget.value}",
            onChanged: widget.canChange ? widget.onChanged : (double val) {},
          ),
        ],
      ),
    );
  }
}
