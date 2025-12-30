import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_bloc.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_event.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_state.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPageContent extends StatelessWidget {
  final String? url;
  const WebviewPageContent({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Device.width,
          height: Device.height,
          child: BlocBuilder<WebviewBloc, WebviewState>(
            builder: (context, state) {
              if (state is Success) {
                return WebViewWidget(controller: state.webViewController);
              }
              if (state is Error) {
                return CustomErrorWidget(
                  error: state.message,
                  onRetry:
                      () => context.read<WebviewBloc>().add(WebviewRetry(url)),
                );
              }
              return LoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
