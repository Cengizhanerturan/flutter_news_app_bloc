import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/setting/pages/update_mail/bloc/update_mail_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class UpdateMailPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentEmailTextEditingController;
  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  const UpdateMailPageContent(
    this.formKey,
    this.currentEmailTextEditingController,
    this.emailTextEditingController,
    this.passwordTextEditingController, {
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
                    title: StringConstants.UPDATE_MAIL_PAGE_TITLE,
                    subtitle: StringConstants.UPDATE_MAIL_PAGE_SUBTITLE,
                  ),
                  CustomTextFormField(
                    controller: currentEmailTextEditingController,
                    padding: AppPadding.all(AppSpacing.md),
                    enabled: false,
                  ),
                  CustomTextFormField(
                    controller: emailTextEditingController,
                    padding: AppPadding.all(AppSpacing.md),
                    hintText: StringConstants.MAIL_TEXT_FIELD_HINT,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validator.validateEmail(value),
                    onChanged: (email) {
                      formKey.currentState?.validate();
                      context.read<UpdateMailBloc>().add(
                        FormChanged(email, passwordTextEditingController.text),
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
                      context.read<UpdateMailBloc>().add(
                        FormChanged(emailTextEditingController.text, password),
                      );
                    },
                  ),
                  BlocConsumer<UpdateMailBloc, UpdateMailState>(
                    listener: (context, state) {
                      if (state is Success) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder:
                              (context) => CustomDialog(
                                message: state.message,
                                primaryButtonOnTap:
                                    () => context.toVerifyMail(
                                      isFromAuthPage: false,
                                      newEmail:
                                          emailTextEditingController.text
                                              .trim(),
                                    ),
                              ),
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
                            (state is Idle) ? state.isButtonEnabled : false,
                        isLoading: state is Loading,
                        onTap: () async {
                          if (state is! Loading) {
                            if (formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();

                              final email = emailTextEditingController.text;
                              final password =
                                  passwordTextEditingController.text;
                              context.read<UpdateMailBloc>().add(
                                FormSubmit(email, password),
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
