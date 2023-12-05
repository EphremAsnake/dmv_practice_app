import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/study_signs/bindings/study_signs_binding.dart';
import '../modules/study_signs/views/study_signs_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';
import '../modules/us_states/bindings/us_states_binding.dart';
import '../modules/us_states/views/us_states_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const FIRST_RUN_INITIAL = Routes.US_STATES;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.US_STATES,
      page: () => UsStatesView(),
      binding: UsStatesBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => TestView(),
      binding: TestBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.STUDY_SIGNS,
      page: () => StudySignsView(),
      binding: StudySignsBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => AboutView(),
      binding: AboutBinding(),
      transition: Transition.fade,
    ),
  ];
}
