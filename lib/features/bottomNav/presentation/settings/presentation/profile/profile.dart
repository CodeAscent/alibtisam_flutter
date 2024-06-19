import 'package:SNP/features/bottomNav/model/user.dart';

import 'package:SNP/core/common/widgets/custom_loading.dart';
import 'package:SNP/core/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
        child: Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            collapsedHeight: 100,
            stretchTriggerOffset: 300.0,
            expandedHeight: 400.0,
            floating: true,
            pinned: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    user.pic,
                    fit: BoxFit.cover,
                    height: 400,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CustomTextField(
                    // suffix: Icon(Icons.edit),
                    initial: user.name,
                    controller: null,
                    label: "name".tr,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    // suffix: Icon(Icons.edit),
                    initial: user.userName,
                    controller: null,
                    label: "userName".tr,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    initial: user.email,
                    controller: null,
                    label: "email".tr,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    // suffix: Icon(Icons.edit),
                    initial: user.mobile,
                    controller: null,
                    label: "phone".tr,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      )),
    ));
  }
}
