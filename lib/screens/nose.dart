import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// main app
void main() {
  runApp(SlideUp());
}

class SlideUp extends StatelessWidget {
  SlideUp({Key? key}) : super(key: key);
// defining border radius
  BorderRadius radius = const BorderRadius.only(
    topLeft: Radius.circular(24),
    topRight: Radius.circular(24),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // scaffold
        appBar: AppBar(
          // appbar with title text
          title: const Text("Sliding Up Panel"),
        ),
        body: SlidingUpPanel(
          // making false it does
          // not render outside
          renderPanelSheet: false,
          // panel
          panel: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 253, 253, 253),
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: Colors.grey,
                  ),
                ]),
            margin: const EdgeInsets.all(24.0),
            child: const Center(
              child: Text("This is the SlidingUpPanel when open"),
            ),
          ),
          // collapsed
          collapsed: Container(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0)),
            ),
            margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
            child: const Center(
              child: Text(
                "This is the collapsed Widget",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: const Center(
            child: Text("This the widget behind the Sliding panel"),
          ),
        ),
      ),
    );
  }
}
