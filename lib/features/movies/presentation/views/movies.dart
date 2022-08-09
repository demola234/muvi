import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Hello"),
            Text("World"),
          ],
        ),
      ),
    );
  }
}
