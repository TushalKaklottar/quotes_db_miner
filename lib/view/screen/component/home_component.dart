import 'package:quotes_db_miner/export_app.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {

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
                return Padding(
                  padding: const EdgeInsets.all(10),
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
                          print('Index: $index, Real Index: $realIndex');
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
                          initialPage: 0,
                          autoPlayInterval: const Duration(seconds: 2),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.linear,
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
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
                                              getAllQuotes = DBHelper.dbHelper.fetchAllQuotes(id: data[index].id
                                              );
                                              Get.toNamed("/detail");
                                            },
                                            child: Container(
                                              height: AppSize.height / 4,
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
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            ...List.generate(
                                5,
                                    (index) =>
                                        Padding(
                                        padding: const EdgeInsets.all(9),
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
                                                  height: AppSize.height / 4,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: MyColor.black,
                                                      width: 1
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
                                              height: AppSize.height / 4,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MyColor.black,
                                                    width: 1
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
                    ],
                  ),
                ),
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

