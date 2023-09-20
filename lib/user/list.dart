import 'package:flutter/material.dart';
import 'package:rentcartest/user/widget.dart';

import 'cart_model.dart';

class list extends StatefulWidget {
  const list({super.key, required this.carsitem});

  final House carsitem;

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
          widget.carsitem.Title.length,
          (index) => homecars(
            carsItem: widget.carsitem,
          ),
        ),
      ],
    );
  }
}
