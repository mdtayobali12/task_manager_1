import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/presentation/controllers/add_new_task_screen_conroller.dart';
import 'package:task_manager_1/presentation/widgets/background_widget.dart';
import 'package:task_manager_1/presentation/widgets/profile_app_bar.dart';



class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key,});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: profileAppBar(),
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: GetBuilder<AddNewTaskScreenController>(builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: controller.titleController,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter title";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 8,
                  controller: controller.descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter description";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Description",
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 16)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: controller.addNewTaskInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          controller.addNewTask(context,);
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),),
          ),
        ),
      ),
    );
  }
}