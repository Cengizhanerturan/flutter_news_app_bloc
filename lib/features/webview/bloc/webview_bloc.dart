import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_event.dart';
import 'package:flutter_news_app/features/webview/bloc/webview_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:logging/logging.dart';

class WebviewBloc extends Bloc<WebviewEvent, WebviewState> {
  WebviewBloc() : super(Loading()) {
    on<WebviewInit>(_onWebviewInit);
    on<WebviewRetry>(_onWebviewRetry);
  }

  Future<void> _onWebviewInit(
    WebviewInit event,
    Emitter<WebviewState> emit,
  ) async {
    try {
      emit(Loading());
      final url = event.url;
      if (url == null) return;
      final webViewController = WebViewController();
      webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (url) => emit(Loading()),
            onPageFinished: (url) => emit(Success(webViewController)),
            onWebResourceError: (error) => emit(Error(error.description)),
          ),
        )
        ..loadRequest(Uri.parse(url));
    } catch (e, st) {
      Logger('WebviewBloc').severe('Webview init failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  Future<void> _onWebviewRetry(
    WebviewRetry event,
    Emitter<WebviewState> emit,
  ) async {
    add(WebviewInit(event.url));
  }
}
