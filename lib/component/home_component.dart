import 'package:flutter/material.dart';
import 'package:quotes_db_miner/controller/index_controller.dart';
import 'package:get/get.dart';

import '../utils/size.dart';


class Home_component extends StatelessWidget {
   Home_component({super.key});

  InitialIndexController initialIndexController = Get.put(InitialIndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
         () {
          return IndexedStack(
                    index: initialIndexController.index.value,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              height: AppSize.height / 4,
                              width: AppSize.width,
                              color: Colors.red,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Popular",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22
                                ),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                     initialIndexController.changeIndex(1);
                                    },
                                    child: Icon(Icons.home),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    onPressed: () {
                                    initialIndexController.changeIndex(0);
                                    },
                                    child: Icon(Icons.home)
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
          );
        }
      ),
    );
  }
}
