import 'package:alibtisam/features/statistics/model/monitoring.dart';
import 'package:alibtisam/core/common/widgets/custom_slider.dart';
import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as ls;

class ReportView extends StatelessWidget {
  final MonitoringModel report;
  const ReportView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    bool canUpdate = false;
    List<Color> colorList = [
      Colors.greenAccent.shade700,
      Colors.blue.shade700,
      primaryColor()
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Player Report on".tr+" \n${customDateTimeFormat(report.updatedAt)}",
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            PieChart(
              dataMap: {
                "trainingLoad".tr: report.trainingLoadOverallPercent.toDouble(),
                "readiness".tr: report.readinessOverallPercent.toDouble(),
                "testResults".tr: report.testResultsOverallPercent.toDouble(),
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
            Divider(),
            Text(
              "readiness".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  letterSpacing: 2,
                  height: 2),
            ),
            CustomSlider(
              value: report.readiness.hydration,
              label: "hydration".tr,
              canChange: canUpdate,
              onChanged: (val) {},
            ),
            CustomSlider(
              value: report.readiness.stress,
              label: "stress".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.readiness.stress = val;
              },
            ),
            CustomSlider(
              value: report.readiness.sleep,
              label: "sleep".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.readiness.sleep = val;
              },
            ),
            CustomSlider(
              value: report.readiness.overall,
              label: "overall".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.readiness.overall = val;
              },
            ),
            CustomSlider(
              value: report.readiness.nutrition,
              label: "nutrition".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.readiness.nutrition = val;
              },
            ),
            CustomSlider(
              value: report.readiness.injury,
              label: "injury".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.readiness.injury = val;
              },
            ),
            Divider(),
            Text(
              "trainingLoad".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  letterSpacing: 2,
                  height: 2),
            ),
            CustomSlider(
              value: report.trainingLoad.monday,
              label: "monday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.monday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.tuesday,
              label: "tuesday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.tuesday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.wednesday,
              label: "wednesday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.wednesday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.thursday,
              label: "thursday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.thursday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.friday,
              label: "friday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.friday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.saturday,
              label: "saturday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.saturday = val;
              },
            ),
            CustomSlider(
              value: report.trainingLoad.sunday,
              label: "sunday".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.trainingLoad.sunday = val;
              },
            ),
            Divider(),
            Text(
              "testResults".tr,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  letterSpacing: 2,
                  height: 2),
            ),
            CustomSlider(
              value: report.testResults.wellness,
              label: "wellness".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.testResults.wellness = val;
              },
            ),
            CustomSlider(
              value: report.testResults.workload,
              label: "workload".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.testResults.workload = val;
              },
            ),
            CustomSlider(
              value: report.testResults.health,
              label: "health".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.testResults.health = val;
              },
            ),
            CustomSlider(
              value: report.testResults.performance,
              label: "performance".tr,
              canChange: canUpdate,
              onChanged: (val) {
                report.testResults.performance = val;
              },
            ),
          ],
        ),
      )),
    );
  }
}
