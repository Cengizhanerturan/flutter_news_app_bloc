import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/setting/bloc/setting_bloc.dart';
import 'package:flutter_news_app/features/setting/view/setting_page_content.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
      create: (context) => SettingBloc(locator<UserRepository>()),
      child: SettingPageContent(),
    );
  }
}
