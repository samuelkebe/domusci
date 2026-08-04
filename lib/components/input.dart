import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:provider/provider.dart';
import '../resources/color.dart';
import '../utils/theme_provider.dart';

class InputText extends StatefulWidget {
  final String labelText;
  final String? hintext;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  const InputText({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.hintext,
    this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _togglePasswordView() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: widget.hintext,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: isDarkMode
              ? Colors.white
              : Colors.black.withOpacity(0.6),
        ),
        labelText: widget.labelText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: isDarkMode ? Colors.white : null,
        ),
        filled: true,
        fillColor: isDarkMode ? AppColors.black2 : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDarkMode
                ? AppColors.black.withOpacity(0.5)
                : AppColors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white
                : AppColors.black.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDarkMode ? AppColors.white.withOpacity(0.5) : AppColors.black,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscure ? Icons.visibility : Icons.visibility_off,
            color: isDarkMode ? Colors.white70 : Colors.black,
          ),
          onPressed: _togglePasswordView,
        )
            : widget.suffixIcon != null
            ? IconTheme(
          data: IconThemeData(
            color: isDarkMode ? Colors.white70 : null,
          ),
          child: widget.suffixIcon!,
        )
            : null,
      ),
    );
  }
}
