import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/todo_home_page/domain/entity/task_entity.dart';
import 'package:todo/features/todo_home_page/domain/usecase/task.usecase.dart';
import 'package:todo/features/todo_home_page/domain/usecase/task_local.usecase.dart';
import 'package:todo/shared/toast_alert.dart';

enum SyncAction { create, update, delete, none }

class TaskProvider extends ChangeNotifier {
  final TaskUseCase taskUseCase;
  final TaskLocalUseCase taskLocalUseCase;

  TaskProvider({required this.taskUseCase, required this.taskLocalUseCase});

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  List<TaskEntity> _constTasksList = [];

  List<TaskEntity> _tasks = [];
  List<TaskEntity> _searchedTasks = [];

  List<TaskEntity> tasksOfDate = [];

  List<TaskEntity> get tasks => _tasks;

  final formKey = GlobalKey<FormState>();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    titleController.text = '';
    descriptionController.text = '';
    notifyListeners();
  }

  TaskEntity? taskEntity;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> addTask(TaskEntity task, Function onSuccess) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      setLoading(true);
      final result = await taskUseCase.addTask(task, userId);
      result.fold(
        (failure) {
          showSnackbar(failure.message, color: Colors.red);
          setLoading(false);
        },
        (addedTask) async {
          _tasks.add(addedTask);
          showSnackbar('Task added successfully', color: Colors.green);
          setLoading(false);
          onSuccess();
          await taskLocalUseCase.addTask(task);

          reset();
          notifyListeners();
        },
      );
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.toString());
      showSnackbar(e.toString(), color: Colors.red);
    }
  }

  Future<void> fetchTasks(String userId) async {
    try {
      setLoading(true);
      final result = await taskUseCase.getAllTasks(userId);
      result.fold(
        (failure) {
          showSnackbar(failure.message, color: Colors.red);
          setLoading(false);
        },
        (fetchedTasks) async {
          _tasks = [];
          _constTasksList = [];
          _constTasksList.addAll(fetchedTasks);
          _tasks.addAll(fetchedTasks);
          await taskLocalUseCase.clearAllTasks();
          for (final task in fetchedTasks) {
            await taskLocalUseCase.addTask(task);
          }

          setLoading(false);
          notifyListeners();
        },
      );
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.toString());
      showSnackbar(e.toString(), color: Colors.red);
    }
  }

  Future<void> fetchTasksByDate(String date) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      setLoading(true);
      final result = await taskUseCase.getTasksByDate(date, userId);
      result.fold(
        (failure) {
          showSnackbar(failure.message, color: Colors.red);
          setLoading(false);
        },
        (fetchedTasks) {
          tasksOfDate = [];
          tasksOfDate.addAll(fetchedTasks);
          setLoading(false);
          notifyListeners();
        },
      );
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.toString());
      showSnackbar(e.toString(), color: Colors.red);
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      setLoading(true);
      final result = await taskUseCase.updateTask(task, userId);
      result.fold(
        (failure) {
          showSnackbar(failure.message, color: Colors.red);
          setLoading(false);
        },
        (_) {
          final index = _tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) {
            _tasks[index] = task;
            notifyListeners();
          }
          showSnackbar('Task updated successfully', color: Colors.green);
          setLoading(false);
        },
      );
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.toString());
      showSnackbar(e.toString(), color: Colors.red);
    }
  }

  Future<void> deleteTask(String taskId, bool isCalendarView) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      setLoading(true);
      final result = await taskUseCase.deleteTask(taskId, userId);
      result.fold(
        (failure) {
          showSnackbar(failure.message, color: Colors.red);
          setLoading(false);
        },
        (_) {
          if (isCalendarView) {
            tasksOfDate.removeWhere((task) => task.id == taskId);
          } else {
            _tasks.removeWhere((t) => t.id == taskId);
          }
          showSnackbar('Task deleted successfully', color: Colors.green);
          setLoading(false);
          notifyListeners();
        },
      );
    } catch (e) {
      setLoading(false);
      setErrorMessage(e.toString());
      showSnackbar(e.toString(), color: Colors.red);
    }
  }

  TaskEntity? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (_) {
      return null;
    }
  }

  void searchTasks(String query) {
    _searchedTasks = _tasks.where((task) {
      final lowerQuery = query.toLowerCase();
      return task.title.toLowerCase().contains(lowerQuery);
    }).toList();
    _tasks.clear();
    _tasks.addAll(_searchedTasks);
    notifyListeners();
  }

  void sortTasksByPriority(String priority) {
    if (priority.isEmpty) {
      _tasks = [];
      _tasks.addAll(_constTasksList);
      notifyListeners();
      return;
    }

    _tasks = _constTasksList
        .where(
          (task) => task.taskPriority.toLowerCase() == priority.toLowerCase(),
        )
        .toList();
    notifyListeners();
  }

  // ---------------- LOCAL TASKS ---------------- //

  Future<void> loadLocalTasks() async {
    final tasks = taskLocalUseCase.getAllTasks();
    _tasks = tasks;
    notifyListeners();
  }

  Future<void> getTasksByDate(String date) async {
    tasksOfDate = taskLocalUseCase.getTasksByDate(date);
    notifyListeners();
  }

  Future<void> addLocalTask(TaskEntity task, Function onSuccess) async {
    await taskLocalUseCase.addTask(task);
    _tasks.add(task);

    onSuccess();
    showSnackbar('Task added successfully', color: Colors.green);

    reset();
    await loadLocalTasks();
  }

  Future<void> deleteLocalTask(String id, {bool isCalendarView = false}) async {
    var task = _tasks.firstWhere((element) => element.id==id,);

    final deletedTask = task.copyWith(syncAction: 'delete',isSynced: false);
    await taskLocalUseCase.updateTask(deletedTask);

    if (isCalendarView) {
      tasksOfDate.removeWhere((t) => t.id == id);
    } else {
      _tasks.removeWhere((t) => t.id == id);
    }

    showSnackbar('Task deleted successfully', color: Colors.green);
    notifyListeners();

  }


}
