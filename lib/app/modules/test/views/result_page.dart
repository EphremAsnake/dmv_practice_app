import 'package:confetti/confetti.dart';
import 'package:drivingexam/app/modules/home/views/widgets/home_ad.dart';
import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:drivingexam/app/modules/test/helper/test_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TestResult extends StatelessWidget {
  TestResult({super.key});

  final TestController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    int incorrectAnswers =
        TestHelper().countErrorsFromResult(controller.results);
    controller.playConfetti();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to("/home");
                    },
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
                            offset: const Offset(
                                0, 1), // horizontal, vertical offset
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 1,
                          height: 1,
                          child: Center(
                            child: Icon(
                              Icons.home_outlined,
                              color: Colors.grey,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const HomeAD(),
              ],
            ),
            Padding(
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
                child: Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        "assets/images/trophy.png",
                        width: 200,
                        height: 200,
                      ),
                      const Text(
                        "You Passed!",
                        style: TextStyle(
                            color: Color(0xFF016A70),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You have made $incorrectAnswers errors out of 35 questions",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<TestController>(
                        builder: (controller) => ConfettiWidget(
                          confettiController: controller.confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: true,
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF016A70),
                            border: Border.all(
                              color: const Color(0xFF016A70),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Expanded(
                                    child: Text(
                                      "Go To Next Test",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            border: Border.all(
                              color: const Color.fromARGB(255, 248, 248, 248),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Expanded(
                                    child: Text(
                                      "Back To Incorrect & Skipped(28)",
                                      style: TextStyle(
                                        color: Color(0xFF016A70),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            border: Border.all(
                              color: const Color.fromARGB(255, 248, 248, 248),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Expanded(
                                    child: Text(
                                      "Restart Test",
                                      style: TextStyle(
                                        color: Color(0xFF016A70),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
