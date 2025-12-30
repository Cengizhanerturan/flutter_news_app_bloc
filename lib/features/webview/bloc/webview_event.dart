import 'package:equatable/equatable.dart';

abstract class WebviewEvent extends Equatable {
  const WebviewEvent();

  @override
  List<Object?> get props => [];
}

class WebviewInit extends WebviewEvent {
  final String? url;

  const WebviewInit(this.url);

  @override
  List<Object?> get props => [url];
}

class WebviewRetry extends WebviewEvent {
  final String? url;

  const WebviewRetry(this.url);

  @override
  List<Object?> get props => [url];
}
