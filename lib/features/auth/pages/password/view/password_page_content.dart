import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/password/bloc/password_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class PasswordPageContent extends StatelessWidget {
  final AUTH_TYPE authType;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordTextEditingController;
  final TextEditingController repasswordTextEditingController;
  const PasswordPageContent(
    this.authType,
    this.formKey,
    this.passwordTextEditingController,
    this.repasswordTextEditingController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: formKey,
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
              onTap: () {
                context.read<AuthBloc>().add(PreviousPage());
              },
            ),
            _buildTitleWidget(),
            _buildPasswordTextField(context),
            _buildRepasswordTextField(context),
            BlocConsumer<PasswordBloc, PasswordState>(
              listener: (context, state) async {
                if (state is Success) {
                  context.read<AuthBloc>().add(UpdatePassword(state.password));
                  switch (authType) {
                    case AUTH_TYPE.LOGIN:
                      final isVerified = state.isVerified;
                      if (isVerified) {
                        context.toHome(replaceAll: true);
                      } else {
                        context.toVerifyMail();
                      }
                      break;
                    case AUTH_TYPE.REGISTER:
                      context.read<AuthBloc>().add(NextPage());
                      break;
                  }
                }
                if (state is Error) {
                  await showDialog(
                    context: context,
                    builder: (context) => CustomDialog(message: state.message),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      FocusScope.of(context).unfocus();
                      final email = context.read<AuthBloc>().state.email;
                      final password = passwordTextEditingController.text;
                      context.read<PasswordBloc>().add(
                        FormSubmit(authType, email, password),
                      );
                    }
                  },
                  isEnabled: state is Idle ? state.isButtonEnabled : false,
                  isLoading: state is Loading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    if (authType == AUTH_TYPE.LOGIN) {
      return TitleWidget(
        title: StringConstants.PASSWORD_PAGE_LOGIN_TITLE,
        subtitle: StringConstants.PASSWORD_PAGE_SUBTITLE,
      );
    }
    return TitleWidget(
      title: StringConstants.PASSWORD_PAGE_REGISTER_TITLE,
      subtitle: StringConstants.PASSWORD_PAGE_SUBTITLE,
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return CustomTextFormField(
      controller: passwordTextEditingController,
      isPassword: true,
      padding: AppPadding.all(AppSpacing.md),
      hintText: StringConstants.PASSWORD_TEXT_FIELD_HINT,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) => Validator.validatePassword(value),
      onChanged: (password) {
        formKey.currentState?.validate();
        context.read<PasswordBloc>().add(FormChanged(authType, password));
      },
    );
  }

  Widget _buildRepasswordTextField(BuildContext context) {
    if (authType == AUTH_TYPE.LOGIN) {
      return const SizedBox.shrink();
    }
    return CustomTextFormField(
      controller: repasswordTextEditingController,
      isPassword: true,
      padding: AppPadding.all(AppSpacing.md),
      hintText: StringConstants.REPEAT_PASSWORD_TEXT_FIELD_HINT,
      keyboardType: TextInputType.visiblePassword,
      validator:
          (value) => Validator.validateRePassword(
            passwordTextEditingController.text,
            value,
          ),
      onChanged: (repassword) {
        formKey.currentState?.validate();
        context.read<PasswordBloc>().add(
          FormChanged(
            authType,
            passwordTextEditingController.text,
            repassword: repassword,
          ),
        );
      },
    );
  }
}
