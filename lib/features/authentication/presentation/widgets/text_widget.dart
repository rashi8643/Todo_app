import 'package:flutter/material.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    final space = AppTheme.of(context).spaces;
    return Text(
      text,
      style: TextStyle(
        color: colors.text,
        fontSize: space.space_400,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
