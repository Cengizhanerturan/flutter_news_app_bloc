import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/registration_details/bloc/registration_details_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class RegistrationDetailsPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController surnameTextEditingController;

  const RegistrationDetailsPageContent(
    this.formKey,
    this.nameTextEditingController,
    this.surnameTextEditingController, {
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
            TitleWidget(
              title: StringConstants.REGISTRATION_DETAILS_PAGE_TITLE,
              subtitle: StringConstants.REGISTRATION_DETAILS_PAGE_SUBTITLE,
            ),
            CustomTextFormField(
              controller: nameTextEditingController,
              padding: AppPadding.all(AppSpacing.md),
              hintText: StringConstants.NAME_TEXT_FIELD_HINT,
              keyboardType: TextInputType.name,
              validator: (value) => Validator.validateName(value),
              onChanged: (name) {
                formKey.currentState?.validate();
                context.read<RegistrationDetailsBloc>().add(
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
                context.read<RegistrationDetailsBloc>().add(
                  FormChanged(nameTextEditingController.text, surname),
                );
              },
            ),
            BlocConsumer<RegistrationDetailsBloc, RegistrationDetailsState>(
              listener: (context, state) async {
                if (state is Success) {
                  context.read<AuthBloc>().add(
                    UpdateUserInformation(state.name, state.surname),
                  );
                  context.toHome(replaceAll: true);
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
                      final name = nameTextEditingController.text;
                      final surname = surnameTextEditingController.text;
                      final email = context.read<AuthBloc>().state.email;
                      context.read<RegistrationDetailsBloc>().add(
                        FormSubmit(name, surname, email),
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
}
