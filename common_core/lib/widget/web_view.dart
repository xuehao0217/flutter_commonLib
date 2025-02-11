import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../base/base_stateful_widget.dart';

class WebViewPage extends StatefulWidget {
  static String Url = "url";
  static String Title = "title";
  final String url = Get.arguments as String? ?? Get.parameters[Url] ?? "";
  final String title = Get.parameters[Title] ?? "";

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends BaseStatefulWidget<WebViewPage> {
  late WebViewController controller;
  String _pageTitle = "Loading..."; // 默认标题
  @override
  void initState() {
    super.initState();
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) async {
                var title =
                    widget.title.isEmpty
                        ? widget.title
                        : await controller.getTitle() ?? "";
                setState(() {
                  _pageTitle = title;
                });
              },
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  String setTitle() {
    return _pageTitle;
  }

  @override
  bool showTitleBar() {
    return !(Uri.parse(widget.url).queryParameters['hideTitle'] ?? "").isNotEmpty;
  }

  @override
  Widget buildPageContent(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
