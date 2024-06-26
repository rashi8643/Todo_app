import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/features/home_page/data/data_source/todo_firestore_data_source.dart';
import 'package:samsidh_task/features/home_page/data/model/todo_model.dart';

part 'todo_firestore_data_source_impl.g.dart';

class TodoFirestoreDataSourceImpl implements TodoFirestoreDataSource {
  final firestore = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser!.uid;
  final collection = FirebaseFirestore.instance.collection(user).withConverter(
        fromFirestore: TodoModel.fromFirestore,
        toFirestore: (model, _) => model.toFirestore(),
      );
  @override
  Future<void> addTodo(TodoModel todo) async {
    await collection.add(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Stream<QuerySnapshot<TodoModel>> getTodo() {
    return collection.snapshots();
  }

  @override
  Future<void> updateTodo(TodoModel todo, String id) async {
    return await collection.doc(id).update(
          todo.toFirestore(),
        );
  }
}

@riverpod
TodoFirestoreDataSource todoFirestoreDataSource(
    TodoFirestoreDataSourceRef ref) {
  return TodoFirestoreDataSourceImpl();
}
