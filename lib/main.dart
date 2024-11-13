import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBepVP3eOjxhx0fcsLeSsSh3L-fwXaDRow",
      authDomain: "1:704994583364:web:52d6c416714cd8fdc6ed11.firebaseapp.com",
      projectId: "1:704994583364:web:52d6c416714cd8fdc6ed11",
      storageBucket: "1:704994583364:web:52d6c416714cd8fdc6ed11.appspot.com",
      messagingSenderId: "704994583364",
      appId: "1:704994583364:web:52d6c416714cd8fdc6ed11",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TaskListScreen(),
    );
  }
}
