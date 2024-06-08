import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';

class ButtonWidget extends ConsumerWidget {
  final String buttonText;
  final void Function()? onPressed;
  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppTheme.of(context).colors;
    final space = AppTheme.of(context).spaces;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: space.space_200,
          color: colors.text,
        ),
      ),
    );
  }
}
