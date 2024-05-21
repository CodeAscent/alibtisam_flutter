import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pie_chart/pie_chart.dart' as ls;
import 'package:flutter/material.dart';

class CoachOverView extends StatefulWidget {
  final dynamic player;
  const CoachOverView({super.key, required this.player});

  @override
  State<CoachOverView> createState() => _CoachOverViewState();
}

class _CoachOverViewState extends State<CoachOverView> {
  dynamic data;
  Map<String, double> dataMap = {};
  

  @override
  void initState() {
    super.initState();
  }

  List<Color> colorList = [
    Colors.greenAccent.shade700,
    Colors.blue.shade700,
    Colors.yellow.shade700
  ];
  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      child: Scaffold(
        appBar: AppBar(
          title: Text("overview".tr),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: !dataMap.isNotEmpty
              ? Center(
                  child: SizedBox(), // or any other loading indicator
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PieChart(
                      dataMap: dataMap,
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
                    SizedBox(height: 60),
                  ],
                ),
        ),
      ),
    );
  }
}
