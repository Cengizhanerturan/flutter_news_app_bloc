import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_bloc.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_event.dart';
import 'package:flutter_news_app/features/webview/view/webview_page_content.dart';

class WebviewPage extends StatelessWidget {
  final String? url;
  const WebviewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebviewBloc()..add(WebviewInit(url)),
      child: WebviewPageContent(url: url),
    );
  }
}
