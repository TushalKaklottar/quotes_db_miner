import 'package:quotes_db_miner/export_app.dart';



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
                                    padding: const EdgeInsets.all(5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        homeController.images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: AppSize.height / 4,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
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
                                   Text(
                                    "Popular",
                                    style: tittleText,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      homeController.changeIndex(1);
                                    },
                                    child: Row(
                                      children:  [
                                        Text(
                                          "See More",
                                          style: buttonText,
                                        ),
                                        const Icon(
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
                                                padding: const EdgeInsets.all(9),
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
                                                        border: Border.all(
                                                            color: MyColor.black,
                                                            width: 1
                                                        ),
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
                                                  // Text("${popular[index]['name']}"),
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
                              Text(
                                "Motivational",
                                style: tittleText,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                child: Row(
                                  children: [
                                    ...List.generate(
                                        5,
                                            (index) =>
                                                Padding(
                                                padding: EdgeInsets.all(9),
                                                  child: Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          attributesController.getCategoryId(
                                                              val: data[index + 5].id
                                                          );
                                                          attributesController.getCategoryName(val: data[index + 5].category_name
                                                          );
                                                          getAllQuotes = DBHelper.dbHelper.fetchAllQuotes(id: data[index +5].id);

                                                          Get.toNamed('/detail');
                                                        },
                                                        child: Container(
                                                          height: 200,
                                                          width: 300,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: MyColor.black,
                                                              width: 2
                                                            ),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                  "${motivational[index]['image']}"
                                                                ),
                                                              fit: BoxFit.cover
                                                            ),
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                            ),
                                    ).toList(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text("Occasional",
                                style: tittleText,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
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
                                                      attributesController.getCategoryId(val: data[index + 10].id);
                                                      attributesController.getCategoryName(val: data[index + 10].category_name);
                                                      getAllQuotes = DBHelper.dbHelper.fetchAllQuotes(id: data[index + 10].id);
                                                      Get.toNamed("/detail");
                                                    },
                                                    child: Container(
                                                      height: 200,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: MyColor.black,
                                                            width: 2
                                                        ),

                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "${occasional[index]['image']}"
                                                          ),
                                                            fit: BoxFit.cover,
                                                        ),
                                                          borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                    ).toList(),
                                  ],
                                )
                              ),

                              const SizedBox(height: 15),
                              Text(
                                "Feelings",
                                style: tittleText,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
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
                                                      attributesController.getCategoryId(val: data[index + 15].id);
                                                      attributesController.getCategoryName(val: data[index + 15].category_name);
                                                      getAllQuotes = DBHelper.dbHelper.fetchAllQuotes(id: data[index + 15].id);

                                                      Get.toNamed("/detail");
                                                    },
                                                    child: Container(
                                                      height: 200,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: MyColor.black,
                                                            width: 2
                                                        ),

                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "${feelings[index]['images']}"
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                    ),
                                  ],
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
        backgroundColor: MyColor.grey100,
      ),
    );
  }
}

