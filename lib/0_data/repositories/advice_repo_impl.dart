import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';

class AdviceRepoImpl extends AdviceRepo {
  final AdviceRemoteDataSources adviceRemoteDataSource;

  AdviceRepoImpl({required this.adviceRemoteDataSource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on CacheException catch (_) {
      return left(CacheFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
