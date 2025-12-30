import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/setting/pages/update_user_information/bloc/update_user_information_bloc.dart';
import 'package:flutter_news_app/features/setting/pages/update_user_information/view/update_user_information_page_content.dart';

class UpdateUserInformationPage extends StatefulWidget {
  const UpdateUserInformationPage({super.key});

  @override
  State<UpdateUserInformationPage> createState() =>
      _UpdateUserInformationPageState();
}

class _UpdateUserInformationPageState extends State<UpdateUserInformationPage> {
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
    return BlocProvider<UpdateUserInformationBloc>(
      create: (context) {
        final bloc = UpdateUserInformationBloc(
          locator<UserService>(),
          locator<UserRepository>(),
        );
        bloc.add(
          LoadUserInformation(
            callback: (String name, String surname) {
              nameTextEditingController.text = name;
              surnameTextEditingController.text = surname;
            },
          ),
        );
        return bloc;
      },
      child: UpdateUserInformationPageContent(
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
