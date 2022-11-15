import 'package:flutter/material.dart';
import 'package:test_text_field/ui/dynamic_text_field/models/dynamic_model.dart';
import 'package:test_text_field/utils/base_class.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dynamic_text_field_bloc.dart';

class DynamicTextFieldWidget extends BaseStateLess {
  @override
  Widget body(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ColumnsInput(),
          _spacer(),
          _CodeInput(),
          _DynamicWidgets(),
        ],
      ),
    ));
  }

  _spacer() {
    return const SizedBox(
      height: 30,
    );
  }
}

class _ColumnsInput extends BaseStateLess {
  @override
  Widget body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(
          flex: 1,
        ),
        const Text(
          "Coloumns : ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
            flex: 5,
            child: BlocBuilder<DynamicTextFieldBloc, DynamicTextFieldState>(
              buildWhen: (previous, current) =>
                  previous.allowedCount != current.allowedCount,
              builder: (context, state) {
                return DropdownButton<int>(
                  value: state.allowedCount ?? 1,
                  //selected
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    context
                        .read<DynamicTextFieldBloc>()
                        .add(ChangeCountsInput(newValue ?? 1));
                  },
                  items:
                      <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                );
              },
            )),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

class _DynamicWidgets extends BaseStateLess {
  @override
  Widget body(BuildContext context) {
    return BlocBuilder<DynamicTextFieldBloc, DynamicTextFieldState>(
      buildWhen: (previous, current) =>
          previous.dynamicList != current.dynamicList,
      builder: (context, state) {
        return Column(
            children: state.dynamicList
                    ?.map((e) => _itemHolder(e, state.dynamicList?.indexOf(e)))
                    .toList() ??
                []);
      },
    );
  }

  Widget _itemHolder(DynamicModel entry, index) {
    MapEntry<String, dynamic> data = entry.entry;
    if (data.value == bool) {
      return _checkBoxItem(entry.value, data.key, index);
    } else {
      return _inputItem(entry.value, data.key, index);
    }
  }

  Widget _checkBoxItem(bool? isChecked, String key, index) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Check Box Type: ",
            textAlign: TextAlign.start,
          ),
          Container(
            width: width,
            height: 2,
            color: Colors.lightBlueAccent,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(key),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked ?? false,
                onChanged: (bool? value) {
                  context
                      .read<DynamicTextFieldBloc>()
                      .add(ChangeItemValue(index, value));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputItem(value, String key, index) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Input Type: ",
            textAlign: TextAlign.start,
          ),
          Container(
            width: width,
            height: 2,
            color: Colors.red,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            // key: const Key('loginForm_usernameInput_textField'),

            onChanged: (txt) => context
                .read<DynamicTextFieldBloc>()
                .add(ChangeItemValue(index, txt)),
            cursorColor: Colors.black,

            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              // isCollapsed: true,
              isDense: true,
              filled: true,

              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: key,
              hintStyle: TextStyle(
                fontSize: fontS(width, 12),
                color: Colors.black.withOpacity(0.3),
                fontFamily: "",
              ),
            ),
            style: TextStyle(
              fontSize: fontS(width, 17),
              color: Colors.black,
              fontFamily: "",
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeInput extends BaseStateLess {
  final _edtController = TextEditingController();

  @override
  Widget body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              context
                  .read<DynamicTextFieldBloc>()
                  .add(FirstInputChanged(_edtController.text));
            },
            child: const Text("Apply")),
        Container(
            width: width / 1.4,
            // height: sizeView(Const.height, 40),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
                borderRadius: BorderRadius.circular(
                  11,
                )),
            child: TextFormField(
              controller: _edtController,
              textAlign: TextAlign.center,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: "Enter your data",
                hintStyle: TextStyle(
                  fontSize: fontS(width, 12),
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              style: TextStyle(
                fontSize: fontS(width, 17),
                color: Colors.black,
              ),
            )),
      ],
    );
  }
}
