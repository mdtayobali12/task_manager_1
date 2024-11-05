import 'package:flutter/material.dart';
import 'package:task_manager_1/data/models/task_list_wrapper.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utility/Urls.dart';
import 'package:task_manager_1/presentation/widgets/background_widget.dart';
import 'package:task_manager_1/presentation/widgets/dash_bord_card.dart';
import 'package:task_manager_1/presentation/widgets/show_snack_bar_message.dart';


import '../utils/app_colors.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card_items.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}
bool _taskListWrapperInProgress = false;
bool _updateTaskInProgress = false;

TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  void getDataFromApi() async {
    getAllTaskCompletedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: BackgroundWidget(
          child: Column(
            children: [
              Expanded(
                child: Visibility(
                  visible: _taskListWrapperInProgress == false &&
                      _updateTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async => getDataFromApi(),
                    child: Visibility(visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
                      replacement: const DashBordCard(),
                      child: ListView.builder(
                          itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                                color: ColorBlue,
                                taskItems: _completedTaskListWrapper.taskList![index],
                                refreshList: () {
                                  getDataFromApi();
                                });
                          }),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }



  Future<void> getAllTaskCompletedList() async {
    setState(() {
      _taskListWrapperInProgress = true;
    });
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper = TaskListWrapper.fromJson(response.ResponseBody);
      ;
      setState(() {
        _taskListWrapperInProgress = false;
      });
    } else {
      if (mounted) {
        showSnackBarMessage(context, "Sorry Task List Getting failed!");
      }
    }
  }
}

