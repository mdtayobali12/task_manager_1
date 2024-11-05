import 'package:flutter/material.dart';
import 'package:task_manager_1/presentation/widgets/dash_bord_card.dart';
import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/Urls.dart';
import '../utils/app_colors.dart';
import '../widgets/background_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/show_snack_bar_message.dart';
import '../widgets/task_card_items.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}
bool _taskListWrapperInProgress = false;
bool _updateTaskInProgress = false;

TaskListWrapper _progressTaskListWrapper = TaskListWrapper();



class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  void getDataFromApi() async {
    getAllTaskProgressList();
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
                    child: Visibility(visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
                      replacement: const DashBordCard(),
                      child: ListView.builder(
                          itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                                color: ColorOrange,
                                taskItems: _progressTaskListWrapper.taskList![index],
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



  Future<void> getAllTaskProgressList() async {
    setState(() {
      _taskListWrapperInProgress = true;
    });
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.ResponseBody);
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