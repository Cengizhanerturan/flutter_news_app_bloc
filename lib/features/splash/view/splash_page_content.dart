import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/features/splash/bloc/splash_bloc.dart';
import 'package:flutter_news_app/widget/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPageContent extends StatelessWidget {
  const SplashPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) async {
          if (state is Success) {
            final isUserAvailable = state.isUserAvailable;
            final isUserVerified = state.isUserVerified;
            if (!isUserAvailable) {
              context.toAuth(replaceAll: true);
            } else {
              if (isUserVerified) {
                context.toHome(replaceAll: true);
              } else {
                context.toVerifyMail(isFromAuthPage: false);
              }
            }
          }
        },
        child: Container(
          width: Device.width,
          height: Device.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              Image.asset(
                AssetConstants.appIconPrimary,
                width: 160.px,
                height: 160.px,
              ),
              LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
