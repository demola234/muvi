import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:moviex/app/app.dart';
import 'package:moviex/bootstrap.dart';
import 'package:moviex/core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector();
  await Hive.initFlutter();
  bootstrap(() => ProviderScope(child: const App()));
}
