import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';

AppState appReducer(AppState state, action) => AppState(tasksReducer(state.tasks, action));

final Reducer<List<TaskItem>> tasksReducer = combineReducers([
  TypedReducer<List<TaskItem>, AddItemAction>(_addItem),
  TypedReducer<List<TaskItem>, RemoveItemAction>(_removeItem),
]);

List<TaskItem> _removeItem(List<TaskItem> tasks, RemoveItemAction action) => List.unmodifiable(List.from(tasks)..remove(action.item));

List<TaskItem> _addItem(List<TaskItem> tasks, AddItemAction action) => List.unmodifiable(List.from(tasks)..add(action.item));

// Needs to be moved to actions.dart file eventually but I'm too lazy right now.

class RemoveItemAction {
  final TaskItem item;

  RemoveItemAction(this.item);
}

class AddItemAction {
  final TaskItem item;

  AddItemAction(this.item);
}
class DisplayListOnlyAction {}

class DisplayListWithNewItemAction {}

class SaveListAction {}
