import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../navigation/routes.dart';
import 'home_state.dart';

final homepageProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState());

  void gotoPage() {
    homeNavigatorKey.currentState!.pushNamed(homePageStudent);
  }

  // void gotoAIPractice() {
  //   homeNavigatorKey.currentState!.pushNamed(aiPage);
  // }

  // void gotoNormalPractice() {
  //   homeNavigatorKey.currentState!.pushNamed(normalPage);
  // }

  void updateHomeState() {}

  void updateHomeStateCategory(var courses) {}
}
