import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

  Future<int> addTask({required Task task}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await DBHelper.insert(task);
      await getTasks();
      return result;
    } catch (e) {
      errorMessage.value = 'Failed to add task: $e';
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  // Get data from database
  Future<void> getTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<Map<String, dynamic>> tasks = await DBHelper.query();
      taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    } catch (e) {
      errorMessage.value = 'Failed to load tasks: $e';
      debugPrint('Error getting tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete tasks from database
  Future<void> deleteTasks(Task task) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await DBHelper.delete(task);
      await getTasks();
    } catch (e) {
      errorMessage.value = 'Failed to delete task: $e';
      debugPrint('Error deleting task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Delete All tasks make UI clear
  Future<void> deleteAllTasks() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await DBHelper.deleteAll();
      await getTasks();
    } catch (e) {
      errorMessage.value = 'Failed to delete all tasks: $e';
      debugPrint('Error deleting all tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update task mark
  Future<void> markAsCompleted(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await DBHelper.update(id);
      await getTasks();
    } catch (e) {
      errorMessage.value = 'Failed to update task: $e';
      debugPrint('Error updating task: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }
}
