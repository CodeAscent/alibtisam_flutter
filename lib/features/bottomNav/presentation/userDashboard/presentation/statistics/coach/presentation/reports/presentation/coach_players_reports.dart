
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class CoachPlayerReport extends StatefulWidget {
  const CoachPlayerReport({super.key, });

  @override
  State<CoachPlayerReport> createState() => _CoachPlayerReportState();
}

class _CoachPlayerReportState extends State<CoachPlayerReport> {
  bool isLoading = false;
  Map<dynamic, dynamic> snapshot = {};
  Map<dynamic, dynamic> readiness = {};
  Map<dynamic, dynamic> trainingLoad = {};
  Map<dynamic, dynamic> testResults = {};



 
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("report".tr),
          surfaceTintColor: Colors.white,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.network(
                         "",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    toBeginningOfSentenceCase("")!,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
                Center(
                  child: Text(
                    "playerId",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ),
                SizedBox(height: 20),
                snapshot["data"] == null
                    ? SizedBox()
                    : AspectRatio(
                        aspectRatio: 1.7,
                        child: BarChart(
                          BarChartData(
                            maxY: 5,
                            groupsSpace: 5,
                            barGroups: [
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["nutrition"].toDouble(),
                                    color: Colors.blue,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["hydration"].toDouble(),
                                    color: Colors.red,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["stress"].toDouble(),
                                    color: Colors.yellow,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["sleep"].toDouble(),
                                    color: Colors.purple,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["overall"].toDouble(),
                                    color: Colors.brown,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: readiness["injury"].toDouble(),
                                    color: Colors.deepOrange,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    width: 13,
                                    toY: trainingLoad["monday"].toDouble(),
                                    color: Colors.blue,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: trainingLoad["tuesday"].toDouble(),
                                    color: Colors.red,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: trainingLoad["wednesday"].toDouble(),
                                    color: Colors.yellow,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: trainingLoad["thursday"].toDouble(),
                                    color: Colors.purple,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: trainingLoad["sunday"].toDouble(),
                                    color: Colors.brown,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(
                                    width: 13,
                                    toY: testResults["wellness"].toDouble(),
                                    color: Colors.blue,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: testResults["workload"].toDouble(),
                                    color: Colors.red,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: testResults["health"].toDouble(),
                                    color: Colors.yellow,
                                  ),
                                  BarChartRodData(
                                    width: 13,
                                    toY: testResults["performance"].toDouble(),
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                            ],
                            titlesData: FlTitlesData(
                                show: true,
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) => value == 1
                                        ? Text("readiness".tr)
                                        : value == 2
                                            ? Text("trainingLoad".tr)
                                            : Text("testResults".tr),
                                  ),
                                )),
                            borderData: FlBorderData(show: false),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  String day = '';
                                  if (groupIndex == 0) {
                                    if (rodIndex == 0) {
                                      day = "Nutrition";
                                    } else if (rodIndex == 1) {
                                      day = "Hydration";
                                    } else if (rodIndex == 2) {
                                      day = "Stress";
                                    } else if (rodIndex == 3) {
                                      day = "Sleep";
                                    } else if (rodIndex == 4) {
                                      day = "Overall";
                                    } else if (rodIndex == 5) {
                                      day = "Injury";
                                    }
                                  } else if (groupIndex == 1) {
                                    if (rodIndex == 0) {
                                      day = "Monday";
                                    } else if (rodIndex == 1) {
                                      day = "Tuesday";
                                    } else if (rodIndex == 2) {
                                      day = "Wednesday";
                                    } else if (rodIndex == 3) {
                                      day = "Thursday";
                                    } else if (rodIndex == 4) {
                                      day = "Sunday";
                                    }
                                  } else {
                                    if (rodIndex == 0) {
                                      day = "Wellness";
                                    } else if (rodIndex == 1) {
                                      day = "Workload";
                                    } else if (rodIndex == 2) {
                                      day = "Health";
                                    } else if (rodIndex == 3) {
                                      day = "Performance";
                                    }
                                  }
                                  return BarTooltipItem(
                                    '$day\n${rod.toY.toStringAsFixed(2)}', // Customizing the tooltip here
                                    TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 10),
                snapshot["data"] == null
                    ? SizedBox()
                    : Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: repeatedTextField("Information"),
                              ),
                              Row(
                                children: [
                                  repeatedTextField("Status"),
                                  SizedBox(
                                    width: 100,
                                    child: Card(
                                  
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                            child: Text(
                                          "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              repeatedTextField(
                                  "Performance: ${testResults["performance"]} / 5"),
                              repeatedTextField(
                                  "Health: ${testResults["health"]} / 5"),
                              repeatedTextField(
                                  "Weekly Peroformance: ${trainingLoad["trainingPercent"].floor()}%"),
                              repeatedTextField(
                                  "Preparation: ${readiness["readinessPercent"].floor()}%"),
                              repeatedTextField(
                                  "Results: ${testResults["testResultsPercent"].floor()}%"),
                            ],
                          ),
                        ),
                      ),
                Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: repeatedTextField("Other Information"),
                          ),
                          repeatedTextField(""),
                          repeatedTextField(""),
                          repeatedTextField(
                              ""),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text repeatedTextField(label) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.w800),
    );
  }
}
