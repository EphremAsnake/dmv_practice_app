import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_page_top_card.dart';
import 'package:drivingexam/app/utils/shared_widgets/pdf_reader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 214, 214, 214)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 1), // horizontal, vertical offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 1,
                        height: 1,
                        child: Image.asset(
                          "assets/images/menu.png",
                        ),
                      ),
                    ),
                  ),
                ),
                const HomeAD(),
              ],
            ),
            const HomePageTopCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(const PDFReader(
                    pdfTitle: "Alaska Drivers Manual",
                    pdfPath: "https://doa.alaska.gov/dmv/dlmanual/dlman.pdf",
                  ));
                },
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
                  height: 50,
                  child: const Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Read Alaska's Drivers Manual",
                            style: TextStyle(
                              color: Color(0xFF016A70),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xFF016A70),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/test");
                      },
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 238, 237, 237),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 8), // horizontal, vertical offset
                              ),
                              BoxShadow(
                                color: Color.fromARGB(255, 238, 237, 237),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(
                                    0, -8), // horizontal, vertical offset
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          child: Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "40 QUESTIONS",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 154, 154),
                                        ),
                                      ),
                                      Text(
                                        "PASSING SCORE 32",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 154, 154),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Practice Test ${index + 1}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Row(
                                        children: [
                                          LineIcon.timesCircle(
                                            size: 20.0,
                                            color: Color(0xFF016A70),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "8 Mistakes Allowed",
                                            style: TextStyle(
                                                color: Color(0xFF016A70)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFF016A70),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 15,
                                          ),
                                          child: Row(
                                            children: [
                                              LineIcon.playCircle(
                                                size: 20.0,
                                                color: Color(0xFF016A70),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "Start",
                                                style: TextStyle(
                                                    color: Color(0xFF016A70)),
                                              ),
                                            ],
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
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
