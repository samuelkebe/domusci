import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({super.key});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final int length = 4;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(length, (index) {
          return SizedBox(
            height: 64,
            width: 64,
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              onChanged: (pin) {
                if (pin.isNotEmpty && index < length - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                } else if (pin.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: textStyle,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "0",
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.onBackground.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.onBackground.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
