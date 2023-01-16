import 'package:flutter/material.dart';

class ItemCountWidget extends StatelessWidget {
  final int count;

  ItemCountWidget({required this.count});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        alignment: Alignment.center,
        color: Colors.orange,
        width: 35,
        height: 35,
        child: Text("$count",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
