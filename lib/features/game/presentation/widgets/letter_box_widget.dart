import 'package:flutter/material.dart';

class LetterBoxWidget extends StatelessWidget {
  final Color? boxColor;
  final Color? textColor;
  final String text;

  const LetterBoxWidget(
      {super.key, this.boxColor, this.textColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
          border: boxColor == null
              ? Border.all(color: Theme.of(context).colorScheme.onSurface)
              : null),
      child: Center(
        child: Text(text,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: textColor
        ),),
      ),
    );
  }
}
