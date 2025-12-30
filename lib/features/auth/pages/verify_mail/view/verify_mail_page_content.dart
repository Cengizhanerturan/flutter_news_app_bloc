import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/verify_mail/bloc/verify_mail_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/widget/title_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerifyMailPageContent extends StatelessWidget {
  final bool isFromAuthPage;
  const VerifyMailPageContent({super.key, required this.isFromAuthPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFromAuthPage)
                CustomBackButton(
                  padding: AppPadding.only(
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    top: AppSpacing.md,
                  ),
                  onTap: () => context.read<AuthBloc>().add(PreviousPage()),
                ),
              TitleWidget(
                title: StringConstants.VERIFY_MAIL_PAGE_TITLE,
                subtitle: StringConstants.VERIFY_MAIL_PAGE_SUBTITLE,
              ),
              BlocConsumer<VerifyMailBloc, VerifyMailState>(
                listenWhen: (previous, current) => current is Error,
                listener: (context, state) async {
                  if (state is Error) {
                    if (state.isTokenExpired) {
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder:
                            (context) => CustomDialog(
                              message: state.message,
                              primaryButtonOnTap:
                                  () => context.toAuth(replaceAll: true),
                            ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (context) => CustomDialog(message: state.message),
                      );
                    }
                  }
                },
                buildWhen: (previous, current) {
                  if (current is Success) return true;
                  if (previous is Loading && current is Loading) return false;
                  if (current is Loading) return true;
                  return false;
                },
                builder: (context, state) {
                  return CustomButton(
                    buttonText: StringConstants.CONTINUE_BUTTON_TEXT,
                    onTap: () {
                      if (state is Success) {
                        context.read<AuthBloc>().add(NextPage());
                      }
                    },
                    isLoading: state is Loading,
                  );
                },
              ),
              BlocBuilder<VerifyMailBloc, VerifyMailState>(
                builder: (context, state) {
                  if (state is! Loading) {
                    return SizedBox();
                  }
                  final text =
                      state.isResendMail
                          ? "Resend email"
                          : "Resend email in ${state.time}s";
                  return InkWell(
                    onTap: () {
                      if (state.isResendMail) {
                        context.read<VerifyMailBloc>().add(ResendMail());
                      }
                    },
                    child: SizedBox(
                      width: Device.width,
                      child: Text(
                        text,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.medium.copyWith(
                          color:
                              state.isResendMail
                                  ? Theme.of(context).primaryColor
                                  : null,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
