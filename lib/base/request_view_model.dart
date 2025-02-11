import 'dart:ui';

import 'package:common_core/base/mvvm/base_refresh_view_model.dart';
import 'package:common_core/base/mvvm/base_view_model.dart';
import 'package:common_core/net/dio_utils.dart';
import 'package:dio/dio.dart';

import '../entity/home_list_entity.dart';
import '../generated/json/base/json_convert_content.dart';

class BaseRequestViewModel extends BaseViewModel {
  void getAsyncRequestNetwork<T>(
    Method method, {
    required String url,
    bool showLoading = false,
    NetSuccessCallback<T>? onSuccess,
    NetErrorCallback? onError,
    VoidCallback? onFinally,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    asyncRequestNetwork(
      method,
      showLoading: showLoading,
      url: url,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      params: params,
      onError: onError,
      onFinally: onFinally,
      onSuccess: (data) {
        onSuccess?.call(JsonConvert.fromJsonAsT<T>(data) as T);
      },
    );
  }

  /// 返回Future 适用于刷新，加载更多
  Future<dynamic> getRequestNetwork<T>(
    Method method, {
    required String url,
    bool showLoading = true,
    Function(T)? onSuccess,
    NetErrorCallback? onError,
    VoidCallback? onFinally,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) {
    return requestNetwork(
      method,
      url: url,
      params: params,
      showLoading:showLoading,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSuccess: (data) {
        onSuccess?.call(JsonConvert.fromJsonAsT<T>(data) as T);
      },
      onError: onError,
      onFinally: onFinally,
    );
  }

}



class BaseRequestListViewModel<T> extends BaseRefreshViewModel<T> {
  void getRefreshListData<T>({
    bool refresh = false,
    required String url,
    Function(T)? success,
  }){
    getRefreshLoadData(url: url,refresh:refresh,success: (data) {
      success?.call(JsonConvert.fromJsonAsT<T>(data) as T);
    });
  }
}
