import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';

class HomePageTopCard extends StatelessWidget {
  const HomePageTopCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 237, 237),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 8), // horizontal, vertical offset
            ),
            BoxShadow(
              color: Color.fromARGB(255, 238, 237, 237),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -8), // horizontal, vertical offset
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 215,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Virginia Driver's Examination",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "(From the 2021 Virginia driver handbook)",
                  style: TextStyle(
                      color: Color.fromARGB(255, 179, 179, 179),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Want To Practice Traffic Signs First ?",
                  style: TextStyle(
                      color: Color(0xFF016A70),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/study-signs');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF016A70),
                          border: Border.all(
                            color: const Color(0xFF016A70),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Row(
                            children: [
                              LineIcon.play(
                                size: 20.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Start Practicing",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}
