import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../res/colors.dart';
import '../../../utils/textInputFormatters.dart';

class textField_widget extends StatefulWidget {
  const textField_widget({
    super.key,
    required this.title,
    this.isobsecure,
    this.hint,
    this.color,
    this.controller,
    this.validator, // Add the validator parameter
    this.applyDecimalFormatting = false, // Default is to apply formatting
  });

  final String title;
  final bool? isobsecure;
  final String? hint;
  final TextEditingController? controller;
  final Color? color;
  final String? Function(String?)? validator;
  final bool applyDecimalFormatting; // New parameter to toggle formatter

  @override
  State<textField_widget> createState() => textField_widgetState();
}

class textField_widgetState extends State<textField_widget> {
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false; // Track error state

  // Call this method to trigger validation manually
  bool validate() {
    final isValid = widget.validator?.call(widget.controller?.text) == null;
    setState(() {
      _hasError = !isValid;
    });
    return isValid;
  }

  @override
  void initState() {
    super.initState();

    // Detect when the TextField loses focus
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _hasError) {
        // When the field loses focus, hide the error
        setState(() {
          _hasError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 12, color: AppColors.primary_orange_color, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        TextFormField(
          keyboardType: widget.applyDecimalFormatting ? const TextInputType.numberWithOptions(decimal: true) : null,
          inputFormatters: widget.applyDecimalFormatting
              ? [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'), // Allows up to 2 decimal places
                  ),
                  DecimalTextInputFormatter(decimalRange: 2), // Custom formatter
                ]
              : [],
          // No formatter if applyDecimalFormatting is false
          focusNode: _focusNode,
          controller: widget.controller,

          // validator: widget.validator, // Attach validator
          // autovalidateMode: AutovalidateMode.disabled, // Use the autovalidateMode

          autofocus: false,
          cursorColor: AppColors.dark_light_text_color,
          onTapOutside: (event) {
            // setState(() {
            //   _hasError = false;
            // });
          },
          onTap: () {
            // print("inside");

            // setState(() {
            //   _hasError = false;
            // });
          },
          onChanged: (value) {
            setState(() {
              _hasError = widget.validator?.call(value) != null;
            });
          },
          style: TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w500),
          obscureText: widget.isobsecure ?? false,
          decoration: InputDecoration(
            // error:  _hasError && widget.validator != null ? Row(
            //   children: [
            //     const Icon(Icons.error ,color: AppColors.primary_orange_color ,size: 14,),
            //     Text(' ${widget.validator!(widget.controller?.text)}',style:  TextStyle(fontSize: 12, color: AppColors.primary_orange_color),)
            //     // widget.validator!(widget.controller?.text)
            //   ],
            // ) : null,

            // errorText: _hasError && widget.validator != null ? widget.validator!(widget.controller?.text) : null,
            // Show error if there's an error
            // errorStyle: TextStyle(fontSize: 12, color: AppColors.primary_orange_color),

            // prefixText: "₹",
            // prefixStyle: TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w500),
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 12, color: widget.color ?? AppColors.primary_orange_color, fontWeight: FontWeight.w400),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color ?? AppColors.primary_orange_color),
              borderRadius: BorderRadius.circular(8.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color ?? AppColors.primary_orange_color),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color ?? AppColors.primary_orange_color),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: widget.color ?? AppColors.primary_orange_color),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: _hasError
              ? Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.error_rounded, color: AppColors.primary_orange_color, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '${widget.validator!(widget.controller?.text)}',
                          style: const TextStyle(fontSize: 12, color: AppColors.primary_orange_color),
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink(), // Empty space if no error
        ),
      ],
    );
  }
}

class textField_second extends StatelessWidget {
  const textField_second({
    super.key,
    required this.title,
    this.isobsecure,
    this.controller,
    this.icon,
    this.hint,
  });

  final String title;
  final String? hint;
  final TextEditingController? controller;
  final IconData? icon;
  final bool? isobsecure;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: AppColors.primary_orange_color, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: screenHeight * 0.005,
        ),
        Container(
          child: TextField(
            onTapOutside: (event) {
              // Unfocus the TextField when tapping outside
              FocusScope.of(context).unfocus();
            },
            style: const TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w500),
            controller: controller,
            obscureText: isobsecure ?? false,
            decoration: InputDecoration(
                suffixIcon: Icon(icon),
                suffixIconColor: AppColors.primary_orange_color,
                fillColor: AppColors.field_color,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.field_color),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.field_color),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.field_color),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.field_color),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 12, color: AppColors.dark_light_text_color, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
