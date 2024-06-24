import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    ValueNotifier<int> buttonNotifier = ValueNotifier(0);

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
                    //User name Text
                    const Text(
                      'HELLO\nUSER',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),

                    //Good Morning Text
                    const Text(
                      'Good Morning',
                      style: TextStyle(
                          color: Colors.white,
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

              //Button Rows
              ValueListenableBuilder(
                  valueListenable: buttonNotifier,
                  builder: (ctx, newValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Today-Button-Container
                        Material(
                          elevation: (newValue == 0) ? 5 : 0,
                          borderRadius: (newValue == 0)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.25,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == 0)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => buttonNotifier.value = 0,
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
                          elevation: (newValue == 1) ? 5 : 0,
                          borderRadius: (newValue == 1)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == 1)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => buttonNotifier.value = 1,
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
                          elevation: (newValue == 2) ? 5 : 0,
                          borderRadius: (newValue == 2)
                              ? BorderRadius.circular(20)
                              : null,
                          color: Colors.transparent,
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: (newValue == 2)
                                  ? const Color.fromARGB(255, 28, 151, 132)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => buttonNotifier.value = 2,
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
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 28, 151, 132),
        ),
      ),
    );
  }
}
