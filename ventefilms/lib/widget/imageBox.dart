import 'package:flutter/material.dart';

class imageBox extends StatelessWidget {
  final List<dynamic> items;

  imageBox({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: items[index].photo,
            title: items[index].titre,
            subtitle: items[index].qualite,
          );
        });
  }
}
