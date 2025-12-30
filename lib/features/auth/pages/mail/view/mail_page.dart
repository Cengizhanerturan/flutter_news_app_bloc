import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/auth/pages/mail/bloc/mail_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/mail/view/mail_page_content.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MailBloc(locator<UserRepository>()),
      child: MailPageContent(formKey, textEditingController),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
