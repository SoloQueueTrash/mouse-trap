import 'package:app/trap.dart';
import 'package:flutter/material.dart';

class TrapControlScreen extends StatefulWidget {
  final Trap trap;

  const TrapControlScreen({required this.trap});

  @override
  _TrapControlScreenState createState() => _TrapControlScreenState();
}

class _TrapControlScreenState extends State<TrapControlScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trap.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ],
        ),
      ),
    );
  }
}