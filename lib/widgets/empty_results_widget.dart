import 'package:flutter/material.dart';

class EmptyResultsWidget extends StatelessWidget {

  final String message; 

  EmptyResultsWidget({required this.message});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
          alignment: Alignment.center,
          width: 200, 
          height: 44,
          color: Colors.blue,
          child:
           Text(message, style: const TextStyle(fontSize: 18, color: Colors.white))),
      ),

    );
  }
}