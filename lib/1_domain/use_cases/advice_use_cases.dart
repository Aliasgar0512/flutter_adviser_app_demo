// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_adviser/1_domain/entities/advice_entity.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';

class AdviceUseCases {
  final AdviceRepo adviceRepo;
  AdviceUseCases({required this.adviceRepo});

  //!
  /*
   TODO : [Either]( from dartz package) 
   * 
   * - work just like its name, with this we can have a function which can 
   *  return from two data type.
   * 
   * - we can use [left()] and [right()] to return whichever datatype we have 
   *    defined on that particular side.
   * 
   *    for example: Either<Failure, AdviceEntity> here [Failure] is in left side 
   *                of [,] and [AdviceEntity] on the right.
   *    so with that we can return any of the two types using [right()] and 
   *    [left()] methods 
   *  
   * 
   */
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    //!
    //* calls repository to get data(failure or data)
    //* proceed with business logic (manipulate the data)

    return adviceRepo.getAdviceFromDataSource();

    //* calls repo when successfully get response.
    //* returning of [AdviceEntity] which is defined right side of [,]

    //* return right(const AdviceEntity(id: 1, advice: 'test advice'));

    //* calls repo there's some kinda error or exception.
    // returning of [Failure] which is defined left side of [,]

    // return left(CacheFailure());
  }
}
