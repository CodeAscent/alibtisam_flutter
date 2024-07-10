import 'package:alibtisam/core/theme/app_colors.dart';
import 'package:alibtisam/features/bottomNav/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewCoachProfile extends StatelessWidget {
  const ViewCoachProfile({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            collapsedHeight: 150,
            stretch: true,
            pinned: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                user.pic,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      kCustomListTile(key: "name".tr, value: user.name),
                      kCustomListTile(key: "email".tr, value: user.email),
                      kCustomListTile(key: "gender".tr, value: user.gender),
                    ]),
              ),
            ),
          )
        ],
      )),
    );
  }

  Container kCustomListTile({required String key, required dynamic value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: kAppGreyColor(), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(key),
        subtitle: Text(
          value.toString().capitalize!,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
