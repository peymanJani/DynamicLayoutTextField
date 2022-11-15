import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/dynamic_model.dart';

part 'dynamic_text_field_event.dart';

part 'dynamic_text_field_state.dart';

class DynamicTextFieldBloc
    extends Bloc<DynamicTextFieldEvent, DynamicTextFieldState> {
  DynamicTextFieldBloc() : super(DynamicTextFieldInitial()) {
    on<FirstInputChanged>(_onFirstInputChanged);
    on<ChangeItemValue>(_onChangeItemValue);
    on<ChangeCountsInput>(_onChangeCountsInput);
  }

  //on change first input value
  FutureOr<void> _onFirstInputChanged(
      FirstInputChanged event, Emitter<DynamicTextFieldState> emit) {
    String str = event.str;

    var list = str.split("\n");

    if(list.length > (state.allowedCount ?? 1)) {
      list = list.sublist(0, state.allowedCount ?? 1);
    }
    List<DynamicModel> l = list.map((e) {
      return DynamicModel(
          entry: MapEntry(e.split(" ").last, _getType(e.split(" ").first)));
    }).toList();
    emit((state.copyWith(dynamicList: l)));
  }

  //detect type of user input
  _getType(String first) {
    switch (first.toLowerCase()) {
      case "bool":
        return bool;
      case "string":
        return String;
    }
  }

  //this method for set value for dynamic list
  FutureOr<void> _onChangeItemValue(
      ChangeItemValue event, Emitter<DynamicTextFieldState> emit) {
    List<DynamicModel> list = [];
    list.addAll(state.dynamicList ?? []);
    list[event.index] = list[event.index].copyWith(value: event.value);
    emit(state.copyWith(dynamicList: list));
  }

  FutureOr<void> _onChangeCountsInput(ChangeCountsInput event, Emitter<DynamicTextFieldState> emit) {
    emit(state.copyWith(allowedCount: event.value));
  }
}
