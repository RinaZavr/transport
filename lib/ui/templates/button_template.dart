import 'package:flutter/material.dart';

class ButtonTemplate extends StatelessWidget {
  final Function onTap;
  final String title;
  const ButtonTemplate({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: Size(size.width, 60),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: (){
          onTap();
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
