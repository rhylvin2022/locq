import 'package:redux/redux.dart';
import 'navigation_action.dart';
import 'navigation_state.dart';

final navigationReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, UpdatePageAction>(_updatePage),
]);

NavigationState _updatePage(
    NavigationState state, UpdatePageAction action) {
  return state.copyWith(currentPage: action.page);
}
