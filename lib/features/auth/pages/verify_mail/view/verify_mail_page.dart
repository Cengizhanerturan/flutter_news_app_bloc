import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/verify_mail/bloc/verify_mail_bloc.dart';
import 'package:flutter_news_app/features/auth/pages/verify_mail/view/verify_mail_page_content.dart';

class VerifyMailPage extends StatefulWidget {
  final bool isFromAuthPage;
  final String? newEmail;
  const VerifyMailPage({super.key, this.isFromAuthPage = true, this.newEmail});

  @override
  State<VerifyMailPage> createState() => _VerifyMailPageState();
}

class _VerifyMailPageState extends State<VerifyMailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = VerifyMailBloc(locator<UserRepository>());
        late String email;
        if (!widget.isFromAuthPage && widget.newEmail != null) {
          email = widget.newEmail!;
        } else {
          email = context.read<AuthBloc>().state.email;
        }
        bloc.add(StartTimer(email, !widget.isFromAuthPage));
        return bloc;
      },
      child: VerifyMailPageContent(isFromAuthPage: widget.isFromAuthPage),
    );
  }
}
