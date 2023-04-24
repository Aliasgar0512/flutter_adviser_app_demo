part of 'adviser_bloc.dart';

//!
/*
 TODO :Equatable(package)
 * 
 * - so by default if we compare
 * two objects of same class with same values then the result will be false
 * because they point to the different memory location,
 * now the solution in dart was to override [==] operator for customization
 * and them perform comparison but the problem was there was too much boiler
 * plate code.
 * 
 * now with [Equatable] we can do the same thing with just extending the 
 * [Equatable] class and overriding [props()] in which we can pass our all the 
 * variables of class that we want to compare.
 * 
 * [Equatable] also provides [EquatableMixin] when a class already has 
 * superclass
 *
 * for more details look here:
 * https://pub.dev/packages/equatable
 * 
 *  
 */

@immutable
abstract class AdviserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviserInitial extends AdviserState {}

class AdviserStateLoading extends AdviserState {}

class AdviserStateLoaded extends AdviserState {
  final String advice;
  AdviserStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdviserStateError extends AdviserState {
  final String errorMessage;
  AdviserStateError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
