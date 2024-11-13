import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_service.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskService taskService = TaskService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: taskService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          final tasks = snapshot.data!.docs;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final title = task['title'];
              final description = task['description'];
              final completed = task['completed'];

              return ListTile(
                title: Text(title),
                subtitle: Text(description),
                trailing: IconButton(
                  icon: Icon(
                    completed ? Icons.check_circle : Icons.circle_outlined,
                    color: completed ? Colors.green : Colors.grey,
                  ),
                  onPressed: () => taskService.toggleTaskCompletion(
                    task.id,
                    completed,
                  ),
                ),
                onLongPress: () => taskService.deleteTask(task.id),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskFormScreen(
                        taskId: task.id,
                        title: title,
                        description: description,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
