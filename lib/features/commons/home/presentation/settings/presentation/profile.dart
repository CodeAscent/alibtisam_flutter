import 'package:alibtisam_flutter/features/commons/home/presentation/settings/models/user.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_loading.dart';
import 'package:alibtisam_flutter/helper/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

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
              background: Image.network(
                user.pic,
                fit: BoxFit.cover,
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
                    suffix: Icon(Icons.edit),
                    initial: user.userName,
                    controller: null,
                    label: "Username",
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    initial: user.email,
                    controller: null,
                    label: "Email",
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    suffix: Icon(Icons.edit),
                    initial: user.mobile,
                    controller: null,
                    label: "Phone",
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    initial: user.role,
                    controller: null,
                    label: "Role",
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
