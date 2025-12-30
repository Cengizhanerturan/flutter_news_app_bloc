import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/mail/bloc/mail_bloc.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailPageContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController textEditingController;
  const MailPageContent(this.formKey, this.textEditingController, {super.key});

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
            SizedBox(height: 54.px),
            TitleWidget(
              title: StringConstants.MAIL_PAGE_TITLE,
              subtitle: StringConstants.MAIL_PAGE_SUBTITLE,
            ),
            CustomTextFormField(
              controller: textEditingController,
              padding: AppPadding.all(AppSpacing.md),
              hintText: StringConstants.MAIL_TEXT_FIELD_HINT,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validator.validateEmail(value),
              onChanged: (email) {
                formKey.currentState?.validate();
                context.read<MailBloc>().add(FormChanged(email));
              },
            ),
            BlocConsumer<MailBloc, MailState>(
              listener: (context, state) async {
                if (state is Success) {
                  final authBloc = context.read<AuthBloc>();
                  authBloc.add(UpdateAuthType(state.authType));
                  authBloc.add(UpdateEmail(state.email));
                  authBloc.add(NextPage());
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
                      final email = textEditingController.text;
                      context.read<MailBloc>().add(FormSubmit(email));
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
