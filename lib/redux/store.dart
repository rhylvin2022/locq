import 'package:redux/redux.dart';


Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      HomeMiddleware(),
      TemplateMiddleware(),
      SplashScreenMiddleware(),
      NavigationMiddleware(),
      EditorMiddleware(),
      LocalMiddleware(),
      EditorFormatMiddleware(),
      PreviewMiddleware(),
      GalleryMiddleware(),
      MusicGalleryMiddleware(),
      LoginMiddleware(),
      SignupMiddleware(),
      VideoTrimmerMiddleware(),
    ],
  );
}
