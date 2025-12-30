import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/mail/view/mail_page.dart';
import 'package:flutter_news_app/features/auth/pages/password/view/password_page.dart';
import 'package:flutter_news_app/features/auth/pages/registration_details/view/registration_details_page.dart';
import 'package:flutter_news_app/features/auth/pages/verify_mail/view/verify_mail_page.dart';

class AuthPageContent extends StatelessWidget {
  final PageController pageController;
  const AuthPageContent(this.pageController, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen:
                (previous, current) => previous.pageIndex != current.pageIndex,
            listener: (context, state) async {
              await pageController.animateToPage(
                state.pageIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                const MailPage(),
                const PasswordPage(),
                const VerifyMailPage(),
                const RegistrationDetailsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
