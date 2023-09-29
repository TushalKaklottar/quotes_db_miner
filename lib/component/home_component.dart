import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_db_miner/helper/db_helper.dart';
import 'package:quotes_db_miner/model/category_database_models.dart';
import 'package:quotes_db_miner/model/quote_modal.dart';
import 'package:quotes_db_miner/utils/attributes.dart';
import 'package:quotes_db_miner/utils/list.dart';
import '../controller/attributes_controller.dart';
import '../controller/home_controller.dart';


class Home_component extends StatefulWidget {
  const Home_component({super.key});

  @override
  State<Home_component> createState() => _Home_componentState();
}

class _Home_componentState extends State<Home_component> {


   AttributesController attributesController = Get.put(AttributesController());
   HomeController homeController = Get.put(HomeController());


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
    return SafeArea(
      child: Scaffold(
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
                return const Center(
                  child: Text("NO DATA AVAILABLE"),
                );
              } else {
                return Obx(
                   () {
                    return IndexedStack(
                      index: homeController.index.value,
                      children: [
                        Padding(padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CarouselSlider.builder(
                                itemCount: homeController.images.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5), // Adjust the padding as needed
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10), // Adjust the radius for circular clipping
                                      child: Image.asset(
                                        homeController.images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 200,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 2),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.linear,
                                  enlargeCenterPage: true, // This makes the center item larger
                                  aspectRatio: 16 / 9, // Set the aspect ratio as needed
                                  viewportFraction: 0.8, // Adjust the visible item fraction
                                  pageSnapping: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),


                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Popular",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      homeController.changeIndex(1);
                                    },
                                    child: Row(
                                      children: const [
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
                                                padding: const EdgeInsets.all(5),
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
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
                                    child: const Text(
                                      "Next",
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => homeController.changeGradientColor(index),
                                child: Container(
                                  height: 300,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        homeController.containerColors.length > index
                                            ? homeController.containerColors[index]
                                            : Colors.red,
                                        Colors.blue,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                        Padding(padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      homeController.changeIndex(0);
                                    },
                                    child: Row(
                                      children: const [
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
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}

