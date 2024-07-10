import 'package:alibtisam/features/bottomNav/presentation/settings/controller/organization.dart';
import 'package:alibtisam/core/common/widgets/custom_loading.dart';
import 'package:alibtisam/core/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutOrganization extends StatefulWidget {
  const AboutOrganization({super.key});

  @override
  State<AboutOrganization> createState() => _AboutOrganizationState();
}

class _AboutOrganizationState extends State<AboutOrganization> {
  final controller = Get.find<OrganizationController>();
  @override
  void initState() {
    super.initState();
    controller.fetchOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        child: GetBuilder(
      initState: (state) {},
      builder: (OrganizationController controller) {
        final organization = controller.about;

        return organization == null
            ? Scaffold()
            : Scaffold(
                appBar: AppBar(
                  title: Text('about'.tr + ' ${organization.name}'),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Image.network(
                              organization.logo,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            organization.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            'foundedOn'.tr +
                                '${customDateFormat(organization.foundedOn)} by ${organization.founder}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'mission'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          organization.mission,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'vision'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          organization.vision,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'description'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          organization.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'location'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          organization.location,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'registrationNumber'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          organization.registrationNumber,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Image.network(
                              organization.banner,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        organization.socialAccount.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'socialMedia'.tr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Wrap(
                                    spacing: 10,
                                    children: organization.socialAccount
                                        .map((account) => IconButton(
                                              icon: Icon(
                                                  getSocialMediaIcon(account)),
                                              onPressed: () {
                                                // Handle social media link
                                              },
                                            ))
                                        .toList(),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
      },
    ));
  }

  IconData getSocialMediaIcon(String account) {
    // Return appropriate icon based on social media platform
    switch (account) {
      case 'facebook':
        return Icons.facebook;
      case 'twitter':
        return Icons.biotech_rounded;
      case 'instagram':
        return Icons.source;
      default:
        return Icons.link;
    }
  }
}
