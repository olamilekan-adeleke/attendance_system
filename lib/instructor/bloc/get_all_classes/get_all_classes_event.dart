part of 'get_all_classes_bloc.dart';

abstract class GetAllClassesEvent extends Equatable {
  const GetAllClassesEvent();
}

class FetchAllClassesEvent extends GetAllClassesEvent {
  @override
  List<Object> get props => [];
}
