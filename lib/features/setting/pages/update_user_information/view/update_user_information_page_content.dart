import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/setting/pages/update_user_information/bloc/update_user_information_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class UpdateUserInformationPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController surnameTextEditingController;
  const UpdateUserInformationPageContent(
    this.formKey,
    this.nameTextEditingController,
    this.surnameTextEditingController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(
                    padding: AppPadding.only(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      top: AppSpacing.md,
                    ),
                  ),
                  TitleWidget(
                    title: StringConstants.UPDATE_USER_INFORMATION_PAGE_TITLE,
                    subtitle:
                        StringConstants.UPDATE_USER_INFORMATION_PAGE_SUBTITLE,
                  ),
                  CustomTextFormField(
                    controller: nameTextEditingController,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.NAME_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.name,
                    validator: (value) => Validator.validateName(value),
                    onChanged: (name) {
                      formKey.currentState?.validate();
                      context.read<UpdateUserInformationBloc>().add(
                        FormChanged(name, surnameTextEditingController.text),
                      );
                    },
                  ),
                  CustomTextFormField(
                    controller: surnameTextEditingController,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.SURNAME_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.name,
                    validator: (value) => Validator.validateSurname(value),
                    onChanged: (surname) {
                      formKey.currentState?.validate();
                      context.read<UpdateUserInformationBloc>().add(
                        FormChanged(nameTextEditingController.text, surname),
                      );
                    },
                  ),
                  BlocConsumer<
                    UpdateUserInformationBloc,
                    UpdateUserInformationState
                  >(
                    listener: (context, state) {
                      if (state is Success) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomDialog(message: state.message),
                        );
                      }

                      if (state is Error) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomDialog(message: state.message),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
                        isEnabled:
                            state is Idle ? state.isButtonEnabled : false,
                        isLoading: state is Loading,
                        onTap: () async {
                          if (state is! Loading) {
                            if (formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();

                              final name = nameTextEditingController.text;
                              final surname = surnameTextEditingController.text;
                              context.read<UpdateUserInformationBloc>().add(
                                FormSubmit(name: name, surname: surname),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
