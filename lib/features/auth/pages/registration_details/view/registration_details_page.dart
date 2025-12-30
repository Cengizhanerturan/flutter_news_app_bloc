import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/auth/pages/registration_details/bloc/registration_details_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/registration_details/view/registration_details_page_content.dart';

class RegistrationDetailsPage extends StatefulWidget {
  const RegistrationDetailsPage({super.key});

  @override
  State<RegistrationDetailsPage> createState() =>
      _RegistrationDetailsPageState();
}

class _RegistrationDetailsPageState extends State<RegistrationDetailsPage> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameTextEditingController;
  late TextEditingController surnameTextEditingController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameTextEditingController = TextEditingController();
    surnameTextEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationDetailsBloc(locator<UserRepository>()),
      child: RegistrationDetailsPageContent(
        formKey,
        nameTextEditingController,
        surnameTextEditingController,
      ),
    );
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    surnameTextEditingController.dispose();
    super.dispose();
  }
}
