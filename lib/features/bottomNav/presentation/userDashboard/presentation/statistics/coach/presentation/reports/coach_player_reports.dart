import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/coach/presentation/reports/report_view.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/controller/reports.dart';
import 'package:alibtisam/features/bottomNav/presentation/userDashboard/presentation/statistics/model/monitoring.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPlayerReports extends StatefulWidget {
  const CoachPlayerReports({super.key});

  @override
  State<CoachPlayerReports> createState() => _CoachPlayerReportsState();
}

class _CoachPlayerReportsState extends State<CoachPlayerReports> {
  final reportsController = Get.find<ReportsController>();
  @override
  void initState() {
    super.initState();
    reportsController.fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (ReportsController reportsController) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(reportsController.reports.length, (int index) {
                MonitoringModel report = reportsController.reports[index]!;
                return CustomContainerButton(
                    flexibleHeight: 100,
                    onTap: () {
                      Get.to(() => ReportView(
                            report: report,
                          ));
                    },
                    label:
                        "Reported on \n${customDateTimeFormat(report.updatedAt)}");
              })
            ],
          ),
        ),
      ),
    );
  }
}
