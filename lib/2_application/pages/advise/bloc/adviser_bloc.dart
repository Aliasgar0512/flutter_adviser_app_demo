import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_event.dart';
part 'adviser_state.dart';

class AdviserBloc extends Bloc<AdviserEvent, AdviserState> {
  AdviserBloc() : super(AdviserInitial()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdviserStateLoading());
      debugPrint('get Advice');
      await Future.delayed(const Duration(seconds: 3), () {});
      debugPrint('got Advice');
      emit(AdviserStateLoaded(advice: 'advice'));
      // emit(AdviserStateError(errorMessage: 'error message'));
    });
  }
}
