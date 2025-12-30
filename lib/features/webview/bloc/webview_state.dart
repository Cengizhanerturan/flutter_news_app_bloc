import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

abstract class WebviewState extends Equatable {
  const WebviewState();

  @override
  List<Object?> get props => [];
}

class Loading extends WebviewState {}

class Success extends WebviewState {
  final WebViewController webViewController;
  const Success(this.webViewController);

  @override
  List<Object?> get props => [webViewController];
}

class Error extends WebviewState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
