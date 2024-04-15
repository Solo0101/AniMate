import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreensNavigatorNotifier extends StateNotifier<int> {
  MainScreensNavigatorNotifier() : super(0);

  void navigateTo(int index){
    if(index != state) {
      state = index;
    }
  }
}
final StateNotifierProvider<MainScreensNavigatorNotifier, int>
mainScreenProvider = StateNotifierProvider((_) => MainScreensNavigatorNotifier());
