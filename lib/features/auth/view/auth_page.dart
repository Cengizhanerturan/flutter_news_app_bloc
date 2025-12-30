import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/view/auth_page_content.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: AuthPageContent(pageController),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
