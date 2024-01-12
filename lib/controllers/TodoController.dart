import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_dewey_app/models/Todo.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class TodoController{
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(Todo todo) async{
    var uuid = const Uuid();
    String newUuid = uuid.v4();
    await todosCollection.doc(newUuid).set({
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
      'isDescDisplayed': todo.isDescDisplayed,
      'timestamp': todo.timestamp,
    });
  }

  Future<void> updateTodo(Todo todo) async{
    await todosCollection.doc(todo.id).update({
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
      'isDescDisplayed': todo.isDescDisplayed,
      'timestamp': todo.timestamp,
    });
  }

  Future<void> deletedTodo(String id) async{
    await todosCollection.doc(id).delete();
  }

  Stream<QuerySnapshot> getTodos(){
    return todosCollection.snapshots();
  }
}