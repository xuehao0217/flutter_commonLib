import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../net/dio_utils.dart';
import 'base_view_abs.dart';
import 'base_view_model.dart';

abstract class BaseRefreshViewModel<T> extends BaseViewModel {
  final controller = RefreshController(initialRefresh: true);

  var pageIndex = 1;

  var defPageIndex=0;
  ///当前页面
  var datas = <T>[].obs;

  var pageCount = 1;

  @override
  void onInit() {
    pageIndex=defPageIndex;
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }

  void requestRefresh(){
    pageIndex=defPageIndex;
    controller.requestRefresh();
  }

  void getRefreshLoadData<T>(
      {required String url,
      bool refresh = false,
      required NetSuccessCallback<T?>? success}) {
    if (refresh) {
      pageIndex = defPageIndex;
    } else {
      pageIndex++;
    }
    requestNetwork<T>(Method.get,
        showLoading: true, url: url, onSuccess: success, onError: (code, str) {
      if (refresh) {
        finishRefresh(success: false);
      } else {
        finishLoad(success: false);
      }
    });
  }

  void onRequestData(
    bool refresh,
    List<T> resultData,
  ) {
    if (refresh) {
      datas.value.clear();
      datas.value = resultData;
      finishRefresh();
    } else {
      datas.addAll(resultData);
      if (resultData.isEmpty || resultData.length < pageCount) {
        finishLoad(noMore: true);
      } else {
        finishLoad();
      }
    }
  }

  /// 完成上拉加载
  void finishRefresh({
    bool success = true,
    bool noMore = false,
  }) {
    if (success) {
      if (noMore) {
        controller.loadNoData();
      }
      controller.refreshCompleted(resetFooterState: !noMore);
    } else {
      controller.refreshFailed();
    }
  }

  /// 完成上拉加载
  void finishLoad({
    bool success = true,
    bool noMore = false,
  }) {
    if (success) {
      if (noMore) {
        controller.loadComplete();
        controller.loadNoData();
      } else {
        controller.loadComplete();
      }
    } else {
      controller.loadFailed();
    }
  }
}