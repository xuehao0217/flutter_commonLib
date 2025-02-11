import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:common_core/base/mvvm/base_vm_stateful_widget.dart';
import 'package:common_core/helpter/widget_ext_helper.dart';
import 'package:common_core/widget/common_list_view.dart';
import 'package:common_core/widget/common_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_commonlib/ui/vm/refresh_list_view_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'vm/home_view_model.dart';

class RefreshListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RefreshListPage();
}

class _RefreshListPage
    extends BaseVMStatefulWidget<RefreshListPage, RefreshListViewModel> {
  @override
  void onPageShow() {
    super.onPageShow();
  }

  @override
  void initData() {}

  @override
  createViewModel() => RefreshListViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildPageContent(BuildContext context) {
    return Stack(
      children: [
        // Text(viewModel.rxBanner.toString(),
        //         style: const TextStyle(fontSize: 12))
        //     .clickInkWell(() {}),

        // CachedNetworkImage(
        //   imageUrl: "http://via.placeholder.com/350x150",
        //   placeholder: (context, url) => CircularProgressIndicator(),
        //   errorWidget: (context, url, error) => Icon(Icons.error),
        // ),
        Obx(() => CommonListWidget(
            visibleIndexListCallback: (indexs) {
              print("visibleIndexListCallback===${indexs}");
            },
            slideDirectionCallback: (direction){
              showToast("slideDirectionCallback===${direction}");
            },
            padding: const EdgeInsets.only(left: 15, right: 15,bottom: 25),
            controller: viewModel.controller,
            enableRefresh: true,
            enableLoad: true,
            itemCount: viewModel.datas.length,
            onRefresh: () {
              viewModel.getDatas(refresh: true);
            },
            onLoad: () {
              viewModel.getDatas();
            },
            itemBuilder: (context, index) {
              return CommonButton(
                elevation: 2,
                circular: 10,
                backgroundColor: getThemeData().primaryColor,
                width: double.infinity,
                height: 50,
                onPressed: () {},
                child: Text(
                  "${viewModel.datas[index].title!}index==${index}",
                  style: const TextStyle(color: Colors.white),
                ).intoPadding(const EdgeInsets.only(left: 15, right: 15)),
              );
            })), // 右下角的圆形按钮
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              viewModel.requestRefresh();
            },
            child: Icon(Icons.upload),
          ),
        ),
      ],
    );
  }
}
