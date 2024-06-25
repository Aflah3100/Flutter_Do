import 'package:flutter/material.dart';
import 'package:flutter_do/database/models/task_model.dart';
import 'package:flutter_do/firebase/firebase_auth/firebase_auth_functions.dart';
import 'package:flutter_do/firebase/firestore/firestore_functions.dart';
import 'package:flutter_do/screens/add_edit_task_screen/screen_add_edit_task.dart';
import 'package:flutter_do/screens/login_screen/signup_login_screen.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key, required this.userName});

  String userName;

  ValueNotifier<Priorities> buttonNotifier = ValueNotifier(Priorities.today);

  //Get-Hour-Function
  String getHour() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        top: false,

        //Base-Container
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),

          //Base-Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //User-Details-Column
              Padding(
                padding: const EdgeInsets.only(top: 80.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //User name Text
                        Text(
                          'HELLO\n${userName.toUpperCase()}',
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        //Sign-Out-Button
                        IconButton(
                            onPressed: () {
                              FirebaseAuthFunctions.instance.signOutUser();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => ScreenSignUpLogin(
                                          initialMode: UserMode.login)));
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),

                    //Good Morning Text
                    Text(
                      getHour(),
                      style: const TextStyle(
                          color: Color.fromARGB(153, 34, 34, 34),
                          fontSize: 25.0,
                          fontFamily: 'PlayWriteNGModern',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),

              //Button Rows Builder
              ValueListenableBuilder(
                  valueListenable: buttonNotifier,
                  builder: (ctx, newValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Today-Button-Container
                        Material(
                          elevation: (newValue == Priorities.today) ? 5 : 0,
                          borderRadius: (newValue == Priorities.today)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == Priorities.today)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  buttonNotifier.value = Priorities.today;
                                },
                                child: const Text(
                                  'Today',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Tomorrow-Button-Container
                        Material(
                          elevation: (newValue == Priorities.tomorow) ? 5 : 0,
                          borderRadius: (newValue == Priorities.tomorow)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == Priorities.tomorow)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  buttonNotifier.value = Priorities.tomorow;
                                },
                                child: const Text(
                                  'Tomorrow',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Next-Week-Button-Container
                        Material(
                          elevation: (newValue == Priorities.nextweek) ? 5 : 0,
                          borderRadius: (newValue == Priorities.nextweek)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == Priorities.nextweek)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  buttonNotifier.value = Priorities.nextweek;
                                },
                                child: const Text(
                                  'Next Week',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),

              ValueListenableBuilder(
                  valueListenable: buttonNotifier,
                  builder: (ctx, newVal, _) {
                    return //Tasks-Stream
                        StreamBuilder(
                            stream: FireStoreFunctions.instance
                                .fetchTaskByPriority(buttonNotifier.value),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasData) {
                                if ((snapshot.data!.docs.isNotEmpty)) {
                                  return Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (ctx, index) {
                                          TaskModel currentTask =
                                              TaskModel.fromMap(snapshot
                                                  .data!.docs[index]
                                                  .data());
                                          return Center(
                                            //List-Tile-Widget
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            ScreenAddEditTask(
                                                              taskMode: TaskMode
                                                                  .editTask,
                                                              task: currentTask
                                                                  .task,
                                                              description:
                                                                  currentTask
                                                                      .taskDescription,
                                                              taskId:
                                                                  currentTask
                                                                      .taskId,
                                                            )));
                                              },
                                              //List-Tile-Card-Widget
                                              child: Card(
                                                color: Colors.transparent,
                                                elevation: 1,
                                                shadowColor:
                                                    const Color.fromARGB(
                                                        255, 228, 227, 227),
                                                child: ListTile(
                                                  title: Center(
                                                    child: Text(
                                                      currentTask.task,
                                                      style: const TextStyle(
                                                          fontSize: 20.0,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  subtitle: Center(
                                                    child: Text(
                                                      currentTask
                                                              .taskDescription ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'Poppins'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (ctx, index) =>
                                            SizedBox(
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
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ScreenAddEditTask(taskMode: TaskMode.addTask)));
        },
        label: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 28, 151, 132),
        ),
      ),
    );
  }
}
