import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_db_miner/utils/size.dart';

class Home_component extends StatefulWidget {
  const Home_component({super.key});

  @override
  State<Home_component> createState() => _Home_componentState();
}

class _Home_componentState extends State<Home_component> {


  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: initialIndex,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                    ),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
            ],
          ),
        ),
      ]
    );
  }
}
