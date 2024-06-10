import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_constants.g.dart';

class AppConstants {
  final String txtAppbarName = 'TODO APP';
  final String txtEnter = 'Pleace Enter TODOs';
  final String txtTask = 'Tasks';
  final String txtCancel = 'Cancel';
  final String txtUpdate = 'Update';
  final String txtCreate = 'Create';
  final String txtDelete = 'Delete';
  final String txtSure = 'Are you sure ?';
  final String txtMassege = 'This todo will delete permenantly';
  final String txtLight = 'Light';
  final String txtDark = 'Dark';
  final String txtError = 'Error,Please try again';
  final String txtNoTodos = "NO TODOS";
  final String txtAddDonation = 'Add Donation';
}

@riverpod
AppConstants appConstants(AppConstantsRef ref) {
  return AppConstants();
}
