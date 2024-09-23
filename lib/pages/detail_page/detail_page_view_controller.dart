import '../../base/view/base_view_controller.dart';

class DetailPageViewController extends IViewController {


  DetailPageViewController({
    required super.apiProvider,
    required super.storageProvider,
  });



  @override
  void initialize() {
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {

    updateState(ViewState(data: "_data"));
  }


}
