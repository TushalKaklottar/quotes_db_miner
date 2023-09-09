import 'package:flutter/material.dart';

class Home_component extends StatelessWidget {
  const Home_component({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(
                  height: 60,
                ),
                Container(
                  height: 250,
                  width: 500,
                  decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.black,
                   ),
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
