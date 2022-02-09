import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/tools_controller.dart';

class ToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ToolsController>(() => ToolsController());
  }
}
