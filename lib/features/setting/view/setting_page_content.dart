import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/features/setting/bloc/setting_bloc.dart';
import 'package:flutter_news_app/features/theme/theme_bloc.dart';
import 'package:flutter_news_app/widget/custom_dialog.dart';
import 'package:flutter_news_app/features/setting/widgets/setting_card.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class SettingPageContent extends StatelessWidget {
  const SettingPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: StringConstants.SETTINGS_PAGE_TITLE,
                subtitle: StringConstants.SETTINGS_PAGE_SUBTITLE,
              ),
              BlocSelector<ThemeBloc, ThemeState, bool>(
                selector: (state) => state.isDark,
                builder: (context, isDark) {
                  return SettingCard(
                    title: StringConstants.DARK_MODE_TITLE,
                    subtitle: StringConstants.DARK_MODE_SUBTITLE,
                    isSwitch: true,
                    switchValue: isDark,
                    switchOnChanged: (value) async {
                      context.read<ThemeBloc>().add(ThemeToggled());
                    },
                  );
                },
              ),
              SettingCard(
                title: StringConstants.UPDATE_USER_INFORMATION_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_USER_INFORMATION_PAGE_SUBTITLE,
                onTap: () {
                  context.toUpdateUserInformation();
                },
              ),
              SettingCard(
                title: StringConstants.UPDATE_MAIL_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_MAIL_PAGE_SUBTITLE,
                onTap: () {
                  context.toUpdateMail();
                },
              ),
              SettingCard(
                title: StringConstants.UPDATE_PASSWORD_PAGE_TITLE,
                subtitle: StringConstants.UPDATE_PASSWORD_PAGE_SUBTITLE,
                onTap: () {
                  context.toUpdatePassword();
                },
              ),
              BlocListener<SettingBloc, SettingState>(
                listener: (context, state) async {
                  if (state is Success) {
                    context.toAuth(replaceAll: true);
                  }
                  if (state is Error) {
                    await showDialog(
                      context: context,
                      builder:
                          (context) => CustomDialog(message: state.message),
                    );
                  }
                },
                child: SettingCard(
                  title: StringConstants.LOGOUT_TITLE,
                  subtitle: StringConstants.LOGOUT_SUBTITLE,
                  icon: Icons.logout_rounded,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder:
                          (context) => CustomDialog(
                            message: StringConstants.LOGOUT_DIALOG_MESSAGE,
                            primaryButtonText:
                                StringConstants.DIALOG_LOGOUT_BUTTON_TEXT,
                            secondaryButtonText:
                                StringConstants.DIALOG_CANCEL_BUTTON_TEXT,
                            primaryButtonOnTap: () async {
                              if (context.read<SettingBloc>().state
                                  is! Loading) {
                                context.read<SettingBloc>().add(Logout());
                              }
                            },
                          ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
