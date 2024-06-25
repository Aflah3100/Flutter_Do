import 'package:flutter/material.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/firebase/firestore/firestore_functions.dart';
import 'package:flutter_do/screens/add_edit_task_screen/screen_add_edit_task.dart';
import 'package:flutter_do/screens/home_screen/widgets/slidable_task_card.dart';
import 'package:flutter_do/utils/enums.dart';

class TasksBuilder extends StatelessWidget {
  const TasksBuilder({
    super.key,
    required this.buttonNotifier,
    required this.scaffoldKey,
    required this.height,
  });

  final ValueNotifier<Priorities> buttonNotifier;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: buttonNotifier,
        builder: (ctx, newVal, _) {
          return //Tasks-Stream
              StreamBuilder(
                  stream: FireStoreFunctions.instance
                      .fetchTaskByPriority(buttonNotifier.value),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      if ((snapshot.data!.docs.isNotEmpty)) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (ctx, index) {
                                TaskModel currentTask = TaskModel.fromMap(
                                    snapshot.data!.docs[index].data());

                                return Center(
                                  //List-Tile-Widget
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ScreenAddEditTask(
                                                    taskMode: TaskMode.editTask,
                                                    task: currentTask.task,
                                                    description: currentTask
                                                        .taskDescription,
                                                    taskId: currentTask.taskId,
                                                  )));
                                    },
                                    //Task-Card-Slidable-Widget
                                    child: SlidableTaskCard(
                                        currentTask: currentTask,
                                        scaffoldKey: scaffoldKey),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) => SizedBox(
                                    height: height * 0.01,
                                  ),
                              itemCount: snapshot.data!.docs.length),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              'No Tasks!',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25.0,
                                  backgroundColor: Colors.transparent,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text(
                          'Error in Fetching Tasks!',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  });
        });
  }
}
