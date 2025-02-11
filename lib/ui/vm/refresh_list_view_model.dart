import 'package:common_core/base/mvvm/base_refresh_view_model.dart';

import '../../base/request_view_model.dart';
import '../../entity/home_list_entity.dart';

// class RefreshListViewModel extends BaseRefreshViewModel<HomeListDatas> {
//   @override
//   void onInit() {
//     defPageIndex = 1;
//     super.onInit();
//   }
//
//   void getDatas({bool refresh = false}) {
//     getRefreshLoadData<HomeListDatas>(
//       refresh: refresh,
//       url: "/article/list/$currentPageIndex/json",
//       success: (data) {
//         onRequestData(refresh, HomeListEntity.fromJson(data).datas);
//       },
//     );
//   }
// }

class RefreshListViewModel extends BaseRequestListViewModel<HomeListDatas> {
  @override
  void onInit() {
    defPageIndex = 1;
    super.onInit();
  }

  void getDatas({bool refresh = false}) {
    getRefreshListData<HomeListEntity>(
      refresh: refresh,
      url: "/article/list/$currentPageIndex/json",
      success: (data) {
        onRequestData(refresh, data.datas);
      },
    );
  }
}
