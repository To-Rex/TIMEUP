import 'package:flutter/material.dart';

class ProfessionsList extends StatelessWidget {
  final List<String> professions;

  const ProfessionsList({Key? key, required this.professions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Expanded(child: Container(color: Colors.red,));
  }
}
