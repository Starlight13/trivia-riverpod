import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.isSelected,
    required this.caption,
    required this.isCorrect,
    required this.onTap,
  });

  final bool isSelected;
  final bool isCorrect;
  final String caption;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: isSelected
            ? WidgetStatePropertyAll(
                isCorrect ? Colors.green : Colors.red,
              )
            : isCorrect && onTap == null
                ? WidgetStatePropertyAll(
                    Colors.green.withOpacity(0.3),
                  )
                : null,
        foregroundColor: isSelected
            ? const WidgetStatePropertyAll(
                Colors.white,
              )
            : null,
      ),
      onPressed: onTap,
      child: Text(
        caption,
        style: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }
}
