import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({super.key, required this.title, this.onPressed, this.isLoading = false});

  final String title;
  Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8FBF3F),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

