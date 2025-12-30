import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_news_app/features/splash/view/splash_page_content.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SplashBloc(locator<UserRepository>())..add(CheckRoute()),
      child: SplashPageContent(),
    );
  }
}
