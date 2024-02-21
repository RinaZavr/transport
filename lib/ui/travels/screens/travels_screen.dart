import 'package:flutter/material.dart';

class TravelsScreen extends StatefulWidget {
  const TravelsScreen({super.key});

  @override
  State<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends State<TravelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Автобусы'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded,),
        ),
      ),
      body: const CustomScrollView(
        slivers: [

        ],
      ),
    );
  }
}