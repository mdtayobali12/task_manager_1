import 'package:flutter/material.dart';
import 'package:task_manager_1/presentation/screen/progress_task_screen.dart';

import '../utils/app_colors.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'new_task_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompletedTaskScreen(),
    const ProgressTaskScreen(),
    const CancelledTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        //   backgroundColor: ColorDarkBlue,
          selectedItemColor: ColorDarkBlue,
          unselectedItemColor: ColorLightGray,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            if (mounted) {
              setState(() {});
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: "New Task"),
            BottomNavigationBarItem(
                icon: Icon(Icons.task_alt), label: "Completed"),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending_outlined), label: "Progress"),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_outlined), label: "Cancelled"),
          ]),
    );
  }
}