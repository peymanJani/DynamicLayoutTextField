part of 'dynamic_text_field_bloc.dart';

abstract class DynamicTextFieldEvent extends Equatable {
  const DynamicTextFieldEvent();
}

class ChangeCountsInput extends DynamicTextFieldEvent {
  int value;

  ChangeCountsInput(this.value);

  @override
  List<Object?> get props => [value];
}
class FirstInputChanged extends DynamicTextFieldEvent {
  String str;

   FirstInputChanged(this.str);

  @override
  List<Object?> get props => [str];
}
  class ChangeItemValue extends DynamicTextFieldEvent {
  int index;

  dynamic value;
  ChangeItemValue(this.index , this.value);

  @override
  List<Object?> get props => [index , value];
}
