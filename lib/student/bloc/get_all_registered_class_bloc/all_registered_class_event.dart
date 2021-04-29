part of 'all_registered_class_bloc.dart';

abstract class AllRegisteredClassEvent extends Equatable {
  const AllRegisteredClassEvent();
}

class FetchAllRegisteredClassEvent extends AllRegisteredClassEvent {
  @override
  List<Object> get props => [];
}
