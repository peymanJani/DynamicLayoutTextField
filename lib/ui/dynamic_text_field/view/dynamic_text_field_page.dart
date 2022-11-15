import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dynamic_text_field_bloc.dart';
import 'dynamic_text_field_widget.dart';


class DynamicTextFieldPage extends StatelessWidget {
  const DynamicTextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test App"),
      ),
      body: BlocProvider(
        create: (_) => DynamicTextFieldBloc(),


        child: DynamicTextFieldWidget(),
      ),
    );
  }
}
