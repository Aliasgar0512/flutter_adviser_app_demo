import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';
import 'package:flutter_adviser/1_domain/use_cases/advice_use_cases.dart';
import 'package:flutter_adviser/2_application/pages/advise/cubit/adviser_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// sl == service locator
final sl = GetIt.I;

Future<void> init() async {
  //! application layer
  // Factory = new instance of specified class every time.

  sl.registerFactory(() => AdviserCubit(adviceUseCase: sl()));
  // sl.registerLazySingleton(() => null) -- for creating a singleton

  //! domain layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  //! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSource: sl()));

  sl.registerFactory<AdviceRemoteDataSources>(
      () => AdviceRemoteDataSourcesImpl(client: sl()));

  //! external (packages)

  sl.registerFactory(() => http.Client());
}
