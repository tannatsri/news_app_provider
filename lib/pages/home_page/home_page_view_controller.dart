import '../../base/view/base_view_controller.dart';
import 'home_page_view_repository.dart';

class HomePageViewController extends IViewController {
  NewsResponseData? _data;

  HomePageViewController({
    required super.apiProvider,
    required super.storageProvider,
  });

  NewsResponseData? get data => _data;

  @override
  void initialize() {
    fetchInitialData();
  }

  Future<void> fetchInitialData({bool isRetry = false}) async {
    if(isRetry) {
      updateState(ViewState.loading());
    }
      final jsonData = await storageProvider.fetchJson('articles');
      if (jsonData != null) {
        _data = NewsResponseData.fromMap(jsonData);
        updateState(ViewState(data: _data));
      }
      final response = await apiProvider.getArticles();
      if (response.isSuccess) {
        _data = NewsResponseData.fromMap(response.data ?? {});
        storageProvider.saveJson('articles', response.data ?? {});
        updateState(ViewState(data: _data));
      } else {
        if(_data == null) {
          updateState(ViewState(errorMessage: "Something went wrong! Please check your internet connection and try again."));
        }
      }

  }

  Future<void> refreshData() async {
    final response = await apiProvider.getArticles();
    final parsedData = NewsResponseData.fromMap(response.data ?? {});
    if (parsedData.articles?.isNotEmpty == false) {
      _data = parsedData;
      storageProvider.saveJson('articles', response.data ?? {});
      updateState(ViewState(data: _data));
    }
  }
}
