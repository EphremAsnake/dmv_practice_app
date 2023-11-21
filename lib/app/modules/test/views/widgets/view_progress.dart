import 'package:drivingexam/app/data/models/result/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProgressCard extends StatelessWidget {
  List<Result> result;
  ProgressCard({
    required this.result,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(result.length, (index) {
                    int number = index + 1;
                    return SizedBox(
                      width: 40,
                      height: 40,
                      child: Card(
                        color: result[index].isCorrect == false
                            ? const Color.fromARGB(255, 255, 17, 0)
                                .withOpacity(0.5)
                            : const Color(0xFF016A70).withOpacity(0.5),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )),
          ),
        ),
      ),
    );
  }
}
