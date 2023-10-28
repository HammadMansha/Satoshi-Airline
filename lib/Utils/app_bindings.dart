import 'package:get/get.dart';
import 'package:satoshi/Controllers/bottom_tab_controllers.dart';
import '../Controllers/tab_controller.dart';
import '../controllers/app_controllers.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TextControllers());
    Get.put(BottomTabController());
    Get.put(TabControllers());

    // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

    // repos
    // Get.lazyPut(() => UpcomingEventRepo(apiClient: Get.find()), fenix: true);

    // Get.lazyPut(
    //   () => UpcomingEventController(upcomingEventRepo: Get.find()),
    //   fenix: true,
    // );
  }
}
