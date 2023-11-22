import 'package:drivingexam/app/modules/test/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FailedWidget extends StatelessWidget {
   FailedWidget({
    super.key,
    required this.incorrectAnswers,
  });

  final int incorrectAnswers;
  final TestController controller = Get.find();
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
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/lose.png",
                width: 200,
                height: 200,
              ),
              const Text(
                "You Failed!",
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
    );
  }
}
