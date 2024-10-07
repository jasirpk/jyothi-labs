import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jyothi_labs/view_model/provider/quantity.dart';

class SelectedQuantityListScreen extends StatelessWidget {
  final String totalQuantity;

  const SelectedQuantityListScreen({
    super.key,
    required this.totalQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final quantities = context.watch<QuantityCount>().quantities;

    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Lists"),
      ),
      body: quantities.isNotEmpty
          ? ListView.builder(
              itemCount: quantities.length,
              itemBuilder: (context, index) {
                if (quantities[index] > 0) {
                  return ListTile(title: Text(totalQuantity));
                } else {
                  return Container(); // Skip items with quantity 0
                }
              },
            )
          : Center(child: Text("No selected quantities")),
    );
  }
}
