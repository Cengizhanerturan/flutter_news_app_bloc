import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/password/bloc/password_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/password/view/password_page_content.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController passwordTextEditingController;
  late TextEditingController repasswordTextEditingController;
  late AUTH_TYPE authType;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    passwordTextEditingController = TextEditingController();
    repasswordTextEditingController = TextEditingController();
    authType = context.read<AuthBloc>().state.authType;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordBloc(locator<UserRepository>()),
      child: PasswordPageContent(
        authType,
        formKey,
        passwordTextEditingController,
        repasswordTextEditingController,
      ),
    );
  }

  @override
  void dispose() {
    passwordTextEditingController.dispose();
    repasswordTextEditingController.dispose();
    super.dispose();
  }
}
