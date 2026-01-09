import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      );
    } else {
      return MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
      );
    }
  }
}
