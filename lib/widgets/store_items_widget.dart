
import 'package:flutter/material.dart';

class StoreItemsWidget extends StatelessWidget {

  Widget _buildItems(BuildContext context, int index) {
    return Text("StoreItemsWidget");
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: 10,
      itemBuilder: _buildItems,
    );
    
  }
}