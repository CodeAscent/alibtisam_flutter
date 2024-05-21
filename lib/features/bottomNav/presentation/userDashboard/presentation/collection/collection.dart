import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('collection'.tr),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              Row(
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.generalDialog(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Scaffold(),
                        );
                      },
                      child: Text("Filter")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 20,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    QuiltedGridTile(2, 2),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 2),
                  ],
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Container(
                                  color: Colors.green,
                                  height: 400,
                                ),
                              ));
                    },
                    child: Container(
                      child: Text(index.toString()),
                      color: Colors.green,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          )),
        ));
  }
}
