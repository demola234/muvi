import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviex/app/app.dart';
import 'package:moviex/bootstrap.dart';
import 'package:moviex/core/di/di.dart';

void main() async {
  await injector();
  bootstrap(() => ProviderScope(child: const App()));
}
