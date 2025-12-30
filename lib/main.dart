import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/theme/themes.dart';
import 'package:flutter_news_app/core/constants/app_constants.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/core/router/app_router.dart';
import 'package:flutter_news_app/data/datasources/local/theme_local_data_source.dart';
import 'package:flutter_news_app/features/theme/theme_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'dart:developer' as developer;

void main() async {
  await _init();
  runApp(MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  await _loadApiKey();
  await Firebase.initializeApp();
  await setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ThemeBloc themeBloc = ThemeBloc(locator<ThemeLocalDataSource>());
        themeBloc.add(ThemeLoadRequested());
        return themeBloc;
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppConstants.appName,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: state.themeMode,
                routerConfig: appRouter,
              );
            },
          );
        },
      ),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    developer.log(
      record.message,
      name: record.loggerName,
      time: record.time,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
}

Future<void> _loadApiKey() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    Logger(
      'Main',
    ).warning('API_KEY is not set. Copy .env.example to .env and set API_KEY.');
  }
}
