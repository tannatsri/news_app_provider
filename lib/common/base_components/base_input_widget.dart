
import 'package:flutter/material.dart';

import 'base_button_widget.dart';
import 'base_text_widget.dart';

enum InputType { email, password, text }

class GenericCallBackList {
  final OnClickCtaListener? onClickListener;
  final OnKeyValueChangeListener? onKeyValueChangeListener;
  final OnKeyValueTypeChangeListener? onKeyValueTypeChangeListener;
  final OnValidationChangeListener? onValidationChangeListener;
  final ChangeValueListener? onRemovalOfKeyListener;

  GenericCallBackList({
    this.onClickListener,
    this.onKeyValueChangeListener,
    this.onKeyValueTypeChangeListener,
    this.onValidationChangeListener,
    this.onRemovalOfKeyListener,
  });
}

typedef OnClickCtaListener = void Function(BaseButtonData? cta);

typedef OnBubbleButtonSelectionChangedCallback = void Function(
    String? value, bool isSelected);

typedef OnBubbleRangeButtonSelectionChangedCallback = void Function(
    String? value, String? type, bool isSelected);

typedef OnAmountChangedCallback = void Function(String?);

typedef OnKeyValueChangeListener = void Function(String? key, String? value);

typedef OnKeyValueTypeChangeListener = void Function(
    {String? key, String? value, String? type});

typedef OnValidationChangeListener = void Function(
    String? key, bool? isValidated);

typedef OnKeyValueActionChangeListener = void Function(
    String? key, String? value, String? action);

typedef ChangeValueListener = void Function(String? value);

typedef OnBubbleButtonShortFormSelectionChangedCallback = void Function(
    String? value, bool isSelected, String shortForm);

class BaseInputWidget extends StatefulWidget {
  final BaseInputWidgetData? data;
  final GenericCallBackList? genericCallBackList;

  const BaseInputWidget({
    required this.data,
    required this.genericCallBackList,
    super.key,
  });

  @override
  State<BaseInputWidget> createState() => _BaseInputWidgetState();
}

class _BaseInputWidgetState extends State<BaseInputWidget> {
  bool _obscureText = true;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {

    widget.genericCallBackList?.onValidationChangeListener?.call(widget.data?.key, false);
    widget.genericCallBackList?.onKeyValueChangeListener?.call(widget.data?.key, "");

  super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    switch (widget.data?.inputType) {
      case InputType.email:
        _errorText = _validateEmail(value) ? null : 'Invalid email';
        break;
      case InputType.password:
        _errorText = _validatePassword(value) ? null : 'Password too weak';
        break;
      case InputType.text:
        _errorText = value.length >= 3 ? null : 'Minimum 3 characters required';
        break;
      case null:
    }
    if (_errorText == null) {
      widget.genericCallBackList?.onValidationChangeListener?.call(widget.data?.key, true);
    } else {
      widget.genericCallBackList?.onValidationChangeListener?.call(widget.data?.key, false);
    }
    widget.genericCallBackList?.onKeyValueChangeListener?.call(widget.data?.key, value);


    setState(() {});
  }

  bool _validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(value);
  }

  bool _validatePassword(String value) {
    return value.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey[200]!), // Add border here
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            obscureText:
                widget.data?.inputType == InputType.password && _obscureText,
            keyboardType: widget.data?.inputType == InputType.email
                ? TextInputType.emailAddress
                : TextInputType.text,
            onChanged: _validateInput,
            decoration: InputDecoration(
              hintText: widget.data?.hintText,
              hintStyle: getBaseTextStyle(
                BaseTextData(
                  font: "caption",
                  color: "#757579",
                ),
              ),
              border: InputBorder.none,
              errorText: null,
              // Hide error text inside the TextField
              suffixIcon: widget.data?.inputType == InputType.password
                  ? IconButton(
                      iconSize: 16,
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: BaseTextWidget(
              data: BaseTextData(
                text: _errorText!,
                color: "#DF3C27",
                font: "caption",
              ),
            ),
          ),
      ],
    );
  }
}

class BaseInputWidgetData {
  final String hintText;
  final InputType inputType;
  final String key;

  BaseInputWidgetData({
    required this.hintText,
    required this.inputType,
    required this.key,
  });
}
