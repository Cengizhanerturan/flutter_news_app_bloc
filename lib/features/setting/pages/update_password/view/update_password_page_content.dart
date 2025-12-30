import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/setting/pages/update_password/bloc/update_password_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class UpdatePasswordPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController repasswordTextEditingController;

  const UpdatePasswordPageContent(
    this.formKey,
    this.currentPasswordTextEditingController,
    this.passwordTextEditingController,
    this.repasswordTextEditingController, {
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
                    title: StringConstants.UPDATE_PASSWORD_PAGE_TITLE,
                    subtitle: StringConstants.UPDATE_PASSWORD_PAGE_SUBTITLE,
                  ),
                  CustomTextFormField(
                    controller: currentPasswordTextEditingController,
                    isPassword: true,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.CURRENT_PASSWORD_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.validatePassword(value),
                    onChanged: (currentPassword) {
                      formKey.currentState?.validate();
                      context.read<UpdatePasswordBloc>().add(
                        FormChanged(
                          currentPassword,
                          passwordTextEditingController.text,
                          repasswordTextEditingController.text,
                        ),
                      );
                    },
                  ),
                  CustomTextFormField(
                    controller: passwordTextEditingController,
                    isPassword: true,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.PASSWORD_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.validatePassword(value),
                    onChanged: (password) {
                      formKey.currentState?.validate();
                      context.read<UpdatePasswordBloc>().add(
                        FormChanged(
                          currentPasswordTextEditingController.text,
                          password,
                          repasswordTextEditingController.text,
                        ),
                      );
                    },
                  ),
                  CustomTextFormField(
                    controller: repasswordTextEditingController,
                    isPassword: true,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.REPEAT_PASSWORD_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.validatePassword(value),
                    onChanged: (repassword) {
                      formKey.currentState?.validate();
                      context.read<UpdatePasswordBloc>().add(
                        FormChanged(
                          currentPasswordTextEditingController.text,
                          passwordTextEditingController.text,
                          repassword,
                        ),
                      );
                    },
                  ),
                  BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
                    listener: (context, state) {
                      if (state is Success) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomDialog(message: state.message),
                        );
                        _clearField();
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
                            (state is Idle) ? state.isButtonEnabled : false,
                        isLoading: state is Loading,
                        onTap: () async {
                          if (state is! Loading) {
                            if (formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();
                              final currentPassword =
                                  currentPasswordTextEditingController.text;
                              final password =
                                  passwordTextEditingController.text;
                              context.read<UpdatePasswordBloc>().add(
                                FormSubmit(currentPassword, password),
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

  void _clearField() {
    currentPasswordTextEditingController.clear();
    passwordTextEditingController.clear();
    repasswordTextEditingController.clear();
  }
}
