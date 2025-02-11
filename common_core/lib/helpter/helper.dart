import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void Get2Named(
  String route, {
  dynamic arguments,
  Map<String, String>? parameters,
}) {
  Get.toNamed(route, arguments: arguments, parameters: parameters);
}
