
import 'package:common_core/base/mvvm/base_view_model.dart';
import 'package:common_core/widget/state_layout.dart';
import 'package:get/state_manager.dart';


class LoadingStateViewModel extends BaseViewModel{

  final Rx<LoadState> loadState = Rx<LoadState>(LoadState.State_Loading);

}