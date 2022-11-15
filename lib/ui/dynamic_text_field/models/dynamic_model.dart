import 'package:equatable/equatable.dart';

class DynamicModel extends Equatable{

  MapEntry<String , dynamic> entry;

  dynamic value;

  DynamicModel({required this.entry , this.value});

  DynamicModel copyWith({
    MapEntry<String, dynamic>? entry,
    dynamic? value,
  }) {
    return DynamicModel(
      entry: entry ?? this.entry,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [entry , value];
}