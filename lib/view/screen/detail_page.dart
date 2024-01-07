import 'package:quotes_db_miner/export_app.dart';

class DetailScreen extends StatelessWidget {
   DetailScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return GetBuilder<AttributesController>(
        builder: (AttributesController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.attributesModel.categoryname.capitalize.toString(),
              style: GoogleFonts.poppins(
                fontSize: AppSize.height * 0.025,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
          body: SizedBox(
            height: AppSize.height,
            width: AppSize.width,
            child: FutureBuilder(
              future: getAllQuotes,
                builder: (context,snapshot) {
                  if(snapshot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapshot.error}"),
                    );
                  } else if(snapshot.hasData) {
                    List<QuotesDatabaseModel>? data = snapshot.data;
                    if(data == null || data.isEmpty) {
                      return const Center(
                        child: Text("No Data Available"),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context,i) => Padding(
                              padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => controller.changeGradientColor(index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            controller.containerColors.length > index
                                           ? controller.containerColors[index]
                                                : Colors.red,
                                            MyColor.blue
                                          ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(controller.attributesModel.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      );
                    }
                  } return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),
          ),
        );
        }
    );
  }
}
