import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 0;
  int hours = 0;
  int minutes = 0;
  String digitSeconds = '00';
  String digitMinutes = '00';
  String digitHours = '00';

  Timer? timer;

  bool timerStarted = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      timerStarted = !timerStarted;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitHours = '00';
      digitMinutes = '00';
      digitSeconds = '00';
      timerStarted = false;
      laps = [];
    });
  }

  void start() {
    timerStarted = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? '$seconds' : '0$seconds';
        digitMinutes = (minutes >= 10) ? '$minutes' : '0$minutes';
        digitHours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  void addLaps() {
    String lap = '$digitHours : $digitMinutes : $digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch App'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' $digitHours : $digitMinutes :  $digitSeconds ',
                      style: const TextStyle(fontSize: 50),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: laps.length,
                          itemBuilder: (context, index) => Row(
                                children: [
                                  Text(
                                    laps[index],
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  )
                                ],
                              )),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blue),
                    child: MaterialButton(
                      onPressed: () {
                        start();
                      },
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: const Text(
                        'Start',
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    addLaps();
                  },
                  child: const Icon(Icons.flag),
                ),
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            reset();
                          },
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: const Text('Reset'),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Column(
//   children: [
//     Center(
//       child: Text(
//         'Stopwatch',
//         style: TextStyle(fontSize: 25, color: Colors.white),
//       ),
//     ),
//   ],
// ),
