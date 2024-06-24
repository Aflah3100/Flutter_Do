import 'package:flutter/material.dart';

enum TaskMode { addTask, editTask }

enum Priorities { today, tomorow, nextweek }

// ignore: must_be_immutable
class ScreenAddEditTask extends StatelessWidget {
  ScreenAddEditTask({super.key, required this.taskMode});
  TaskMode taskMode;

  final _taskFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  ValueNotifier<Priorities> priorityNotifier = ValueNotifier(Priorities.today);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF80D8FF),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Create Task',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //Base-Container
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: width,
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF80D8FF), Color(0xFF64FFDA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            )),

            //Base-Column
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading-Text
                  const Text(
                    "Schedule Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 27.0,
                        fontFamily: 'Rubik',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),

                  //Task-TextField
                  TextFormField(
                    focusNode: _taskFocusNode,
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Task',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.blueGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0))),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),

                  //Description-TextField
                  TextFormField(
                    focusNode: _descriptionFocusNode,
                    maxLength: 40,
                    maxLines: 2,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(color: Colors.blueGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 2.0))),
                  ),

                  SizedBox(
                    height: height * 0.02,
                  ),

                  //Priority-Text
                  const Text(
                    "Priority",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        fontFamily: 'Rubik',
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),

                  //Priroty-Container-Row
                  ValueListenableBuilder(
                      valueListenable: priorityNotifier,
                      builder: (ctx, priority, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Today-Container
                            Container(
                              width: width * 0.20,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                  color: (priority == Priorities.today)
                                      ? const Color.fromARGB(255, 10, 215, 238)
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () =>
                                      priorityNotifier.value = Priorities.today,
                                  child: const Text(
                                    'Today',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),

                            //Tomorrow-Container
                            Container(
                              width: width * 0.25,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                  color: (priority == Priorities.tomorow)
                                      ? const Color.fromARGB(255, 10, 215, 238)
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 128, 116, 6)),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => priorityNotifier.value =
                                      Priorities.tomorow,
                                  child: const Text(
                                    'Tomorrow',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),

                            //NextWeek-Container
                            Container(
                              width: width * 0.28,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                  color: (priority == Priorities.nextweek)
                                      ? const Color.fromARGB(255, 10, 215, 238)
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => priorityNotifier.value =
                                      Priorities.nextweek,
                                  child: const Text(
                                    'Next Week',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(
                    height: height * 0.06,
                  ),

                  //Add-Task-Button-Container
                  Container(
                    width: width,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.black, Colors.black54],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topCenter),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Center(
                        child: Text(
                      'Add Task',
                      style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
