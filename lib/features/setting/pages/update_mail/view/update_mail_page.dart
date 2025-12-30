import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/setting/pages/update_mail/bloc/update_mail_bloc.dart';
import 'package:flutter_news_app/features/setting/pages/update_mail/view/update_mail_page_content.dart';

class UpdateMailPage extends StatefulWidget {
  const UpdateMailPage({super.key});

  @override
  State<UpdateMailPage> createState() => _UpdateMailPageState();
}

class _UpdateMailPageState extends State<UpdateMailPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController currentEmailTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    currentEmailTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = UpdateMailBloc(
          locator<UserService>(),
          locator<UserRepository>(),
        );
        bloc.add(
          LoadEmail(
            callback: (String email) {
              currentEmailTextEditingController.text = email;
            },
          ),
        );
        return bloc;
      },
      child: UpdateMailPageContent(
        formKey,
        currentEmailTextEditingController,
        emailTextEditingController,
        passwordTextEditingController,
      ),
    );
  }

  @override
  void dispose() {
    currentEmailTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
