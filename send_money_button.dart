// lib/widgets/send_money_button.dart
import 'package:flutter/material.dart';

class SendMoneyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading; // Optional: for showing a loading state

  const SendMoneyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor, // Use primary color
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
    );
  }
}