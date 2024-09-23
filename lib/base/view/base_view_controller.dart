import 'package:flutter/material.dart';
import 'package:news_app/base/provider/network_provider.dart';
import 'package:news_app/base/provider/storage_provider.dart';

abstract class IViewController<T> extends ChangeNotifier {
  final NetworkAssistantProvider apiProvider;
  final StorageAssistantProvider storageProvider;

  IViewController({
    required this.apiProvider,
    required this.storageProvider,
  });

  ViewState<T> get state => _state;

  void updateState(ViewState<T> newState) {
    print("tanishq --- getting printed");
    print("tanishq --- getting printed  -- new state ${newState.isLoading}");
    _state = newState;
    notifyListeners();
  }

  ViewState<T> _state = ViewState<T>.loading();

  void initialize();
}

class ViewState<T> {
  final T? data;
  final bool isLoading;
  final String? errorMessage;

  ViewState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  // Loading state
  factory ViewState.loading() {
    return ViewState(isLoading: true);
  }

  // Data state
  factory ViewState.data(T data) {
    return ViewState(data: data, isLoading: false);
  }

  // Error state
  factory ViewState.error(String message) {
    return ViewState(errorMessage: message, isLoading: false);
  }
}