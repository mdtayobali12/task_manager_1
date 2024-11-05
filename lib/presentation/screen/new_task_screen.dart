import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/presentation/widgets/dash_bord_card.dart';
import '../../data/models/task_by_status_data.dart';
import '../controllers/count_task_by_status.dart';
import '../controllers/new_task_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/background_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card_items.dart';
import '../widgets/task_counter.dart';
import 'add_new_Task_screen.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}
bool _updateTaskInProgress = false;

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  void getDataFromApi() async {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(),
      body: BackgroundWidget(
          child: Column(
            children: [
              GetBuilder<CountTaskByStatusController>(
                  builder: (countTaskByStatusController) {
                    return Visibility(
                        visible: countTaskByStatusController.inProgress == false,
                        replacement: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(),
                        ),
                        child: taskCounterSection(countTaskByStatusController
                            .countByStatusWrapper.listOfTaskStatusData ??
                            []));
                  }),
              Expanded(
                child: GetBuilder<NewTaskController>(builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.inProgress == false &&
                        _updateTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () async => getDataFromApi(),
                      child: Visibility(
                        visible: newTaskController
                            .newTaskListWrapper.taskList?.isNotEmpty ??
                            false,
                        replacement: const DashBordCard(),
                        child: ListView.builder(
                            itemCount: newTaskController
                                .newTaskListWrapper.taskList?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                  color: ColorGreen,
                                  taskItems: newTaskController
                                      .newTaskListWrapper.taskList![index],
                                  refreshList: () {
                                    getDataFromApi();
                                  });
                            }),
                      ),
                    ),
                  );
                }),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorBlue,
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen(),
                ));
          },
          label: const Text("Add")),
    );
  }

  Widget taskCounterSection(
      List<TaskCountBuyStatusData> listOfTaskCountBuyStatusData) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountBuyStatusData.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) {
            return const SizedBox(width: 5);
          },
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: listOfTaskCountBuyStatusData[index].sId ?? "",
              amount: listOfTaskCountBuyStatusData[index].sum ?? 0,
            );
          },
        ),
      ),
    );
  }
}