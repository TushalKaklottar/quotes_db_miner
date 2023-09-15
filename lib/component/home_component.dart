import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_db_miner/model/category_database_models.dart';
import 'package:quotes_db_miner/helper/db_helper.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_db_miner/controller/attributes_controller.dart';
import 'package:quotes_db_miner/controller/index_controller.dart';



import 'package:quotes_db_miner/utils/attributes.dart';
import '../utils/image_list.dart';
import '../utils/size.dart';


class Home_component extends StatelessWidget {
   Home_component({super.key});

  InitialIndexController initialIndexController = Get.put(InitialIndexController());
  AttributesController attributesController = Get.put(AttributesController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllCategory,
        builder: (context,snapshot) {
      if (snapshot.hasError) {
        return Center(
          child: Text("ERROR: ${snapshot.error}"),
        );
      } else if (snapshot.hasData) {
        List<CategoryDataModel>? data = snapshot.data;

        if (data == null || data.isEmpty) {
          return const Center(
            child: Text("NO DATA AVAILABLE"),
          );
        } else {
          return Obx(() {
                return IndexedStack(
                  index: initialIndexController.index.value,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
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
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage("assets/images/logo.png"),
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Popular",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    initialIndexController.changeIndex(1);
                                  },
                                  child: const Icon(Icons.home),
                                )
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        // decoration: BoxDecoration(
                                        //   image: DecorationImage(
                                        //       image: AssetImage(
                                        //           "${popular[index]['image']}"
                                        //       ),
                                        //   )
                                        // ),
                                      )
                                    ],
                                  )
                                ],
                              ),
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
                                  child: Icon(Icons.ac_unit_rounded)
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
          );
        }
      }
      return const Center(child: CircularProgressIndicator(),
      );
    }
      )
    );
  }
}