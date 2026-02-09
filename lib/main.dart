import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tgpl_network/common/providers/shared_prefs_provider.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/routes/app_router.dart';

final providerLogger = ProviderLogger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await DatabaseHelper.instance.database;

  // await DatabaseHelper.instance.clearAllTables(); // Uncomment to clear all tables during development

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      observers: [providerLogger],
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget screenBuilder(BuildContext context, Widget? child) {
    return SafeArea(child: child!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) {
        if (Theme.of(context).platform == TargetPlatform.iOS) {
          return CupertinoApp.router(
            routerConfig: goRouter,
            builder: screenBuilder,
            debugShowCheckedModeBanner: false,
          );
        } else {
          return MaterialApp.router(
            routerConfig: goRouter,
            builder: screenBuilder,
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}


final class ProviderLogger extends ProviderObserver {
  final List<ProviderBase> _providers = [];

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _providers.add(context.provider);
    super.didAddProvider(context, value);
  }

  void invalidateAll([Ref? ref1, WidgetRef? ref2]) {
    for (final provider in _providers) {
      if (ref1 != null) {
        ref1.invalidate(provider);
      }
      if (ref2 != null) {
        ref2.invalidate(provider);
      }
    }
    _providers.clear();
  }
}