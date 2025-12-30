import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_news_app/features/home/view/home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeBloc(locator<NewsRepository>(), locator<UserService>())
                ..add(FetchNews()),
      child: HomePageContent(),
    );
  }
}
