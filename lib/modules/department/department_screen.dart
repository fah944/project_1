import 'package:flutter/material.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Text('department screen',
      style: Theme.of(context).textTheme.bodyLarge,),);
  }
}
