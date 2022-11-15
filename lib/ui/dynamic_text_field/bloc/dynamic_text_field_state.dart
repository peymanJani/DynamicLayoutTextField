part of 'dynamic_text_field_bloc.dart';

class DynamicTextFieldState extends Equatable {
  DynamicTextFieldState({this.dynamicList,this.allowedCount});

  List<DynamicModel>? dynamicList;
  int? allowedCount;




  @override
  List<Object?> get props => [dynamicList , allowedCount];

  DynamicTextFieldState copyWith({
    List<DynamicModel>? dynamicList,
    int? allowedCount,
  }) {
    return DynamicTextFieldState(
      dynamicList: dynamicList ?? this.dynamicList,
      allowedCount: allowedCount ?? this.allowedCount,
    );
  }
}

class DynamicTextFieldInitial extends DynamicTextFieldState {
  @override
  List<Object> get props => [];
}
