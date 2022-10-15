import 'package:meta/meta.dart';

/// Page Enum
enum PageEnum {login, googleMap, search }

@immutable
class NavigationState {
  final PageEnum currentPage;

  const NavigationState({required this.currentPage});

  factory NavigationState.initial() {
    return const NavigationState(
      currentPage: PageEnum.login,
    );
  }

  NavigationState copyWith({required PageEnum currentPage}) {
    return NavigationState(currentPage: currentPage);
  }
}
