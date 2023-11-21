import 'package:flutter/material.dart';

class HomeAD extends StatelessWidget {
  const HomeAD({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ace Your DMV Written Test with",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF016A70).withOpacity(0.5),
                  border: Border.all(
                    color: const Color(0xFF016A70).withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
                  child: Text("Cheat Sheet",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
