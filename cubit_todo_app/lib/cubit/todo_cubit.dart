import 'package:cubit_todo_app/model/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit todo class
class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  //create and update state
  void addTodo(String title, String discription) {
    if (title.isEmpty) {
      addError("title cannot be empty");
    }
    final todo = Todo(
      title: title,
      discription: discription,
      isCompleted: false,
    );
    //update current state/add new todo for avalible todos list
    //state.add(todo); //but this is not recomended

    //push updates/new todo list
    emit([...state, todo]); //recomended way
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
    print(error);
  }
}
