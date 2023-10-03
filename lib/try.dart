import 'package:flutter/material.dart';

class Exam1 extends StatelessWidget {
  const Exam1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cropped Child Containers Example')),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              padding: const EdgeInsets.all(20.0),
            ),
          ),
          Center(
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 190,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 410,
              width: 412,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 60),
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}