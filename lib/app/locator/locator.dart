import 'package:get_it/get_it.dart';
import '../../services/internal.dart';

GetIt locator = GetIt.I;
setUpLocator() {
  locator.registerLazySingleton<Internal>(() => GetStatus());
}
