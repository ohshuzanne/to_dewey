import 'package:to_dewey_app/controllers/AlertDialogController.dart';
import 'package:to_dewey_app/controllers/TodoController.dart';
import 'package:to_dewey_app/models/Todo.dart';
import 'package:to_dewey_app/models/enums/CRUD.dart';
import 'package:to_dewey_app/views/components/CustomShadowTextField.dart';
import 'package:flutter/material.dart';

class ManageToDoView extends StatelessWidget{
  const ManageToDoView({
    super.key,
    required this.todoController,
    required this.alertDialogController,
    required this.tTextController,
    required this.dTextController,
    required this.pageController,
    required this.crud,
    this.todo,
  });

  final TodoController todoController;
  final AlertDialogController alertDialogController;
  final TextEditingController tTextController;
  final TextEditingController dTextController;
  final PageController pageController;
  final CRUD crud;
  final Todo? todo;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                crud == CRUD.C ? 'Add Todo': 'Update Todo',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
             ),
             CustomShadowTextField(
                textController: tTextController,
                title: 'Title',
                hintText: 'Ex: To Do',
                maxLines: 1,
             ),

            CustomShadowTextField(
                textController: dTextController,
                title: 'Description',
                hintText: 'Ex: Description',
                maxLines: 5,
                ),
            Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                if (tTextController.text == ""){
                  alertDialogController.displayAlertDialog(context, crud, "Title Cannot Be Empty");
                  return;
                }
                if (dTextController==""){
                  alertDialogController.displayAlertDialog(context, crud, "Description Cannot Be Empty");
                  return;
                }

                switch (crud){
                  case CRUD.C:
                    DateTime now = DateTime.now();
                    int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
                    String epochTime = millisecondsSinceEpoch.toString();
                    var newTodo = Todo(
                      id: '',
                      title: tTextController.text,
                      description: dTextController.text,
                      isCompleted: false,
                      isDescDisplayed: false,
                      timestamp: epochTime,
                    );
                    todoController.addTodo(newTodo);

                    FocusScope.of(context).unfocus();
                    pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                    break;
                  case CRUD.U:
                    todo?.title=tTextController.text;
                    todo?.description=dTextController.text;
                    todoController.updateTodo(todo!);
                    Navigator.pop(context);
                    break;
                  default:
                    break;
                  }

                tTextController.text="";
                dTextController.text="";
              },
              child: Text(crud==CRUD.C ? 'Add Todo': 'Update Todo'),
            ),
          ),
        ],
      ),
    ),
  ),
  );
  }
}