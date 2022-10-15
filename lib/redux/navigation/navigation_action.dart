import 'navigation_state.dart';

enum NavigationAction {
  pushReplaceGoogleMapPage,
  popSearchPage,
}

class UpdatePageAction {
  PageEnum page;
  UpdatePageAction(this.page);
  @override
  String toString() {
    return '${super.toString()} :  ${this.page}';
  }
}