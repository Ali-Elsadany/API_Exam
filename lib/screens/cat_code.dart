import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatCodeScreen extends StatelessWidget {
  final String catId;

  CatCodeScreen({required this.catId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cat Code Details'),
      ),
      body: Center(
        child: Text('Cat ID: $catId'),
      ),
    );
  }
}