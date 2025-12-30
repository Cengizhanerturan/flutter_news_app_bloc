import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/setting/pages/update_password/bloc/update_password_bloc.dart';
import 'package:flutter_news_app/features/setting/pages/update_password/view/update_password_page_content.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController currentPasswordTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController repasswordTextEditingController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    currentPasswordTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    repasswordTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordBloc(locator<UserRepository>()),
      child: UpdatePasswordPageContent(
        formKey,
        currentPasswordTextEditingController,
        passwordTextEditingController,
        repasswordTextEditingController,
      ),
    );
  }

  @override
  void dispose() {
    currentPasswordTextEditingController.dispose();
    passwordTextEditingController.dispose();
    repasswordTextEditingController.dispose();
    super.dispose();
  }
}
