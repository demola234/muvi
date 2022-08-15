import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:moviex/app/app.dart';
import 'package:moviex/bootstrap.dart';
import 'package:moviex/core/di/di.dart';

import 'features/movies/data/model/bookmarked.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector();
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(BookmarkedAdapter());
  bootstrap(() => ProviderScope(child: const App()));
}
