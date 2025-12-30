import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/features/discover/bloc/discover_bloc.dart';
import 'package:flutter_news_app/features/discover/view/discover_page_content.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: NEWS_CATEGORY.values.length,
      vsync: this,
    );
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DiscoverBloc(locator<NewsRepository>())..add(FetchNews()),
      child: DiscoverPageContent(tabController, pageController),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
