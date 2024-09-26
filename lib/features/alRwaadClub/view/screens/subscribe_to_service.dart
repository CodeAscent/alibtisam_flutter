import 'package:alibtisam/core/common/constants/custom_listtile_card.dart';
import 'package:alibtisam/core/common/widgets/custom_container_button.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:alibtisam/core/utils/custom_snackbar.dart';
import 'package:alibtisam/features/alRwaadClub/models/alRwaad_service.dart';
import 'package:alibtisam/features/alRwaadClub/viewModel/alrwaad_viewmodel.dart';
import 'package:alibtisam/features/bottomNav/controller/user.dart';
import 'package:alibtisam/features/enrollment/models/user.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SubscribeToService extends StatefulWidget {
  final AlRwaadService service;
  const SubscribeToService({super.key, required this.service});

  @override
  State<SubscribeToService> createState() => _SubscribeToServiceState();
}

class _SubscribeToServiceState extends State<SubscribeToService> {
  final userController = Get.find<UserController>();
  bool alreadySubscribed = false;
  late SubscribedServices subscribedServices;
  checkIfAlreadySubscribed() async {
    for (var service in userController.user!.subscribedServices!) {
      Logger().w("${service.id}");
      Logger().w("${widget.service.id}");
      if (service.serviceId == widget.service.id) {
        alreadySubscribed = true;
        subscribedServices = service;
      }
    }
    setState(() {});
  }

  final alrwaadViewmodel = Get.find<AlrwaadViewmodel>();

  @override
  void initState() {
    super.initState();
    checkIfAlreadySubscribed();
  }

  String selectedServicePlan = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: !alreadySubscribed && widget.service.type != 'FREE',
        child: CustomContainerButton(
            onTap: () async {
              if (selectedServicePlan == '') {
                customSnackbar('Select a plan first', ContentType.help);
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Alert'),
                      content: Text(
                          'Are you sure you want to subscribe this service with $selectedServicePlan Plan?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () async {
                              Get.back();
                              await alrwaadViewmodel.subscribeToService(
                                  serviceId: widget.service.id!,
                                  selectedPlan: selectedServicePlan);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    );
                  },
                );
              }
            },
            flexibleHeight: 60,
            label: 'Subscribe this service'),
      ),
      body: Obx(
        () => alrwaadViewmodel.loading.value
            ? CustomLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _buildServiceCard(widget.service),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: SafeArea(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 198, 198, 198),
                              child: Icon(
                                Icons.navigate_before,
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: widget.service.type != 'FREE',
                    replacement: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FREE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text('This service is free of cost'),
                          ),
                        ],
                      ),
                    ),
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              Wrap(
                                children: [
                                  ...widget.service.pricing.map((e) => Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                            width: Get.width * 0.45,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: selectedServicePlan ==
                                                        e['plan']
                                                    ? Colors.blue.shade100
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(width: 2)),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (!alreadySubscribed) {
                                                  setState(() {
                                                    selectedServicePlan =
                                                        e['plan'];
                                                  });
                                                }
                                              },
                                              child: kCustomListTile(
                                                key: e['plan'],
                                                value: e['price'].toString(),
                                              ),
                                            )),
                                      )),
                                ],
                              ),
                              SizedBox(height: 40),
                              if (alreadySubscribed)
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                              'You have subscribed to this service')),
                                      SizedBox(height: 10),
                                      Text(
                                        'Plan Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      Text(subscribedServices.plan! +
                                          ' ' +
                                          'Plan'),
                                      SizedBox(height: 10),
                                      Text("${subscribedServices.price}" +
                                          ' ' +
                                          'SAR'),
                                      SizedBox(height: 10),
                                      Text("Subscribed on" +
                                          ' ' +
                                          '${customDateFormat(subscribedServices.subscribedAt!)}'),
                                      SizedBox(height: 10),
                                      if (subscribedServices.subscriptionEnds !=
                                          null)
                                        Text("Subscription Ends on" +
                                            ' ' +
                                            '${customDateFormat(subscribedServices.subscriptionEnds!)}'),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildServiceCard(AlRwaadService service) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          // Background card with rounded corners
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                service.icon!,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Service info
          Positioned(
            bottom: 15,
            left: 15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (service.arabicName!.isNotEmpty)
                      Text(
                        service.arabicName!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
