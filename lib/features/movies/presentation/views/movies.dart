import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/notifiers/movies_notifier.dart';

class Movies extends ConsumerWidget {
  const Movies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello"),
            Text("World"),
            ElevatedButton(
                onPressed: () {
                  ref.watch(getSchedulesProvider);
                },
                child: Text("Testing Response"))
          ],
        ),
      ),
    );
  }
}
