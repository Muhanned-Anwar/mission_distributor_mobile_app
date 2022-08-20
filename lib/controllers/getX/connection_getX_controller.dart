import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mission_distributor/controllers/storage/network/api/controllers/app_api_controller.dart';
import 'package:mission_distributor/models/gift.dart';

class ConnectionGetXController extends GetxController {

  final RxString _connectionStatus = ConnectivityResult.none.name.obs;


  static ConnectionGetXController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> changeConnection(
      {required String status}) async {
    _connectionStatus.value = status;
    _connectionStatus.refresh();
  }




  String get connectionStatus => _connectionStatus.value;
}
