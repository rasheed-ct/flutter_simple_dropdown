import 'package:flutter/material.dart';
import 'package:flutter_simple_dropdown/flutter_simple_dropdown.dart';

class FlutterSimpleDropdownExample extends StatelessWidget {
  const FlutterSimpleDropdownExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(child: Text('Example of dropdown ' , style: Theme.of(context).textTheme.headlineMedium,)),
            FlutterSimpleDropdown()
          ],
        ),
      ),
    );
  }
}
