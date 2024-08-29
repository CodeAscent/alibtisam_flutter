import 'package:alibtisam/features/statistics/controller/monitoring.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as ls;

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final monitoringController = Get.find<MonitoringController>();
    List<Color> colorList = [
      Colors.greenAccent.shade700,
      Colors.blue.shade700,
      primaryColor()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('overview'.tr),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PieChart(
            dataMap: {
              "trainingLoad".tr: monitoringController
                  .monitoring!.trainingLoadOverallPercent
                  .toDouble(),
              "readiness".tr: monitoringController
                  .monitoring!.readinessOverallPercent
                  .toDouble(),
              "testResults".tr: monitoringController
                  .monitoring!.testResultsOverallPercent
                  .toDouble(),
            },
            animationDuration: Duration(milliseconds: 1000),
            chartLegendSpacing: 70,

            chartRadius: Get.width / 1.7,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 50,
            // centerText: "HYBRID",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: ls.LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          ),
        ],
      )),
    );
  }
}
