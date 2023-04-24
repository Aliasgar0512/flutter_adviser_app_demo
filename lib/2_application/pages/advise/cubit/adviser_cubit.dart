import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adviser/1_domain/failures/failures.dart';
import 'package:flutter_adviser/1_domain/use_cases/advice_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_cubit_state.dart';

const generalErrorMessage = 'Something wen wrong!';
const cacheErrorMessage = 'Cache Error';
const serverErrorMessage = 'Server Error';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit({required this.adviceUseCase}) : super(AdviserInitial());
  final AdviceUseCases adviceUseCase;

  //* so in Cubit we can emit states but cant track events like in BLoC pattern
  void adviceRequested() async {
    emit(AdviserStateLoading());
    debugPrint('get Advice');

    final failureOrAdviceEntity = await adviceUseCase.getAdvice();

    //* [fold()] from 'dartz class which can be used to get [right] or [left]'s
    //* datatype's output
    failureOrAdviceEntity.fold(
        //* in [fold()] we will get the object of the both [Either] types.
        (failure) =>
            emit(AdviserStateError(errorMessage: _mapFailureMessage(failure))),
        (advice) => emit(AdviserStateLoaded(advice: advice.advice)));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverErrorMessage;
      case CacheFailure:
        return cacheErrorMessage;
      default:
        return generalErrorMessage;
    }
  }
}
