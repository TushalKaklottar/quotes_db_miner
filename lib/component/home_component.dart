import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_db_miner/helper/db_helper.dart';
import 'package:quotes_db_miner/model/category_database_models.dart';
import 'package:quotes_db_miner/model/quote_modal.dart';
import 'package:quotes_db_miner/utils/attributes.dart';
import 'package:quotes_db_miner/utils/list.dart';

import '../controller/attributes_controller.dart';

class Home_component extends StatefulWidget {
  const Home_component({super.key});

  @override
  State<Home_component> createState() => _Home_componentState();
}

class _Home_componentState extends State<Home_component> {

   List<Color> containerColors = [];

   Color getRandomColor() {
     return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
         .withOpacity(1.0);
   }

   void changeGradientColor(int index) {
     setState(() {
       if (containerColors.length <= index) {
         containerColors.add(getRandomColor());
       } else {
         containerColors[index] = getRandomColor();
       }
     });
   }

  AttributesController attributesController = Get.put(AttributesController());

  int initialIndex = 0;

 QuoteModal? quote;

  Future<void>  fetchRandomQuote() async {
    quote = await APIHelper.apiHelper.fetchQuote();
    if(quote != null) {
      await saveToSharedPreference(quote!);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategory = DBHelper.dbHelper.fetchAllCategory();
    fetchRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getAllCategory,
        builder: (context,snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("ERROR : ${snapshot.error}"),
              ),
            );
          } else if (snapshot.hasData){
            List<CategoryDatabaseModel>? data =snapshot.data;

            if (data == null || data.isEmpty) {
              return Center(
                child: Text("NO DATA AVAILABLE"),
              );
            } else {


              return IndexedStack(
                index: initialIndex,
                children: [
                  Padding(padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 250,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            image: DecorationImage(
                              image:
                              AssetImage("assets/images/popular/p4.jpg"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  initialIndex = 1;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "See More",
                                  ),
                                  Icon(
                                    Icons.expand_more,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                  5,
                                      (index) => Padding(
                                          padding: EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                attributesController.
                                                getCategoryId(val: data[index].id);

                                                attributesController.
                                                getCategoryName(val: data[index].category_name);

                                                getAllQuotes = DBHelper.dbHelper.fetchAllQuotes(id: data[index].id);

                                                Get.toNamed("/detail");
                                              },
                                              child: Container(
                                                height: 200,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "${popular[index]['image']}"
                                                      ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Text("${popular[index]['name']}"),
                                          ],
                                        ),
                                      ),
                              ).toList(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Random Quote",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  fetchRandomQuote();
                                });
                              },
                              child: Text(
                                "Next",
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => changeGradientColor(index),
                          child: Container(
                            height: 300,
                            width: 200
                          ),
                        )
                      ],
                    ),
                  ),
                  ),


                  Padding(padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  initialIndex = 0;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "See",
                                  ),
                                  Icon(
                                    Icons.expand_less,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )

                ],
              );

            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:quotes_db_miner/model/category_database_models.dart';
// import 'package:quotes_db_miner/helper/db_helper.dart';
//
//
// import 'package:google_fonts/google_fonts.dart';
// import 'package:quotes_db_miner/controller/attributes_controller.dart';
// import 'package:quotes_db_miner/controller/index_controller.dart';
// import 'package:quotes_db_miner/utils/app_color.dart';
//
//
//
// import 'package:quotes_db_miner/utils/attributes.dart';
// import 'package:share_plus/share_plus.dart';
// import '../model/quote_modal.dart';
// import '../utils/list.dart';
// import '../utils/size.dart';
//
//
// class Home_component extends StatefulWidget {
//    Home_component({super.key});
//
//   @override
//   State<Home_component> createState() => _Home_componentState();
// }
//
// class _Home_componentState extends State<Home_component> {
//
//
//
//   InitialIndexController initialIndexController = Get.put(InitialIndexController());
//   AttributesController attributesController = Get.put(AttributesController());
//
//
// List<Color> containerColors = [];
//
//
//   void changeGradientColor(int index) {
//     setState(() {
//       if (containerColors.length <= index) {
//         containerColors.add(getRandomColor());
//       } else {
//         containerColors[index] = getRandomColor();
//       }
//     });
//   }
//
//   Color getRandomColor() {
//     return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
//         .withOpacity(1.0);
//   }
//
//
//   QuoteModal? quote;
//   @override
//   void initState() {
//     super.initState();
//     getAllCategory = DB_helper.db_helper.fatchAllCategory();
//     fetchRandomQuote();
//   }
//   Future<void> fetchRandomQuote() async {
//     quote = await APIHelper.apiHelper.fetchQuote();
//
//     if(quote != null) {
//       await saveToSharedPreference(quote!);
//     }
//     setState(() {});
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getAllCategory,
//         builder: (context,snapshot) {
//       if (snapshot.hasError) {
//         return Padding(
//           padding: const EdgeInsets.all(12),
//           child: Center(
//             child: Text("ERROR: ${snapshot.error}"),
//           ),
//         );
//       } else if (snapshot.hasData) {
//         List<CategoryDataModel>? data = snapshot.data;
//
//         if (data == null || data.isEmpty) {
//           return const Center(
//             child: Text("NO DATA AVAILABLE"),
//           );
//         } else {
//           return Obx(() {
//                 return IndexedStack(
//                   index: initialIndexController.index.value,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               height: 60,
//                             ),
//                             Container(
//                               height: AppSize.height / 4,
//                               width: AppSize.width,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(20),
//                                 image: const DecorationImage(
//                                     image: AssetImage("assets/images/logo.png"),
//                                     fit: BoxFit.cover
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Popular",
//                                   style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 OutlinedButton(
//                                   onPressed: () {
//                                     initialIndexController.changeIndex(1);
//                                   },
//                                   child: const Icon(Icons.home),
//                                 )
//                               ],
//                             ),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               physics: BouncingScrollPhysics(),
//                               child: Row(
//                                 children: [
//                                   ...List.generate(
//                                     5,
//                                     (index) => Padding(
//                                       padding: const EdgeInsets.all(5),
//                                       child: Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: () {
//                                               attributesController.getCategoryId(
//                                                   val: data[index].id
//                                               );
//                                               attributesController.getCategoryName(
//                                                   val: data[index].category_name
//                                               );
//
//                                               getAllQuotes = DB_helper.db_helper.fatchAllQuotes(
//                                                   id: data[index].id
//                                               );
//                                               Get.toNamed('/detail');
//                                             },
//                                             child: Container(
//                                               height: 100,
//                                               width: 100,
//                                               decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: AssetImage(
//                                                         "${popular[index]['image']}"
//                                                     ),
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                           ),
//                                           Text("${popular[index]['name']}"),
//                                         ],
//                                       ),
//                                     ),
//                                   ).toList(),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Random Quotes",
//                                   style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                                 OutlinedButton(
//                                     onPressed: () {
//                                       fetchRandomQuote();
//                                     },
//                                     child: Text("Next"),
//                                 )
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () => changeGradientColor(index),
//                               child: Container(
//                                 height: AppSize.height * 35,
//                                 width: AppSize.width,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       colors:[
//                                         containerColors.length > index
//                                         ? containerColors[index]
//                                             : MyColor.red,
//                                         MyColor.blue,
//                                       ],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsets.all(16),
//                                   child: Center(
//                                     child: Text(
//                                       quote?.content ??
//                                           "Don\'t talk about what you have done or what you are going to do.",
//                                       textAlign: TextAlign.justify,
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: AppSize.height * 0.08,
//                               width: AppSize.width,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         Clipboard.setData(
//                                           ClipboardData(
//                                             text: quote?.content ?? "",
//                                           )
//                                         ).then((value) => Get.snackbar(
//                                           "Quote", "Successfully Copy",
//                                             snackPosition:
//                                             SnackPosition.BOTTOM,
//                                             backgroundColor:
//                                             Colors.grey.withOpacity(0.5),
//                                             duration:
//                                             const Duration(seconds: 3),
//                                             animationDuration:
//                                             const Duration(seconds: 1)
//                                         )
//                                         );
//                                       },
//                                       icon: Icon(Icons.copy)
//                                   ),
//                                   IconButton(
//                                       onPressed: () {
//                                         Get.snackbar("Quote",
//                                             "Successfully download your Gallery",
//                                             snackPosition:
//                                             SnackPosition.BOTTOM,
//                                             backgroundColor:
//                                             Colors.grey.withOpacity(0.5),
//                                             duration:
//                                             const Duration(seconds: 3),
//                                             animationDuration:
//                                             const Duration(seconds: 1));
//                                       },
//                                     icon: Icon(
//                                       Icons.download,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       Get.snackbar("Quote",
//                                           "Successfully Save to Your Favourite",
//                                           snackPosition:
//                                           SnackPosition.BOTTOM,
//                                           backgroundColor:
//                                           Colors.grey.withOpacity(0.5),
//                                           duration:
//                                           const Duration(seconds: 3),
//                                           animationDuration:
//                                           const Duration(seconds: 1));
//                                     },
//                                     icon: Icon(
//                                       Icons.favorite_border,
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () async {
//                                       await Share.share(quote?.content ?? "");
//                                     },
//                                     icon: Icon(
//                                       Icons.share,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               OutlinedButton(
//                                   onPressed: () {
//                                     initialIndexController.changeIndex(0);
//                                   },
//                                   child: Icon(Icons.ac_unit_rounded)
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               }
//           );
//         }
//       }
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//       )
//     );
//   }
// }