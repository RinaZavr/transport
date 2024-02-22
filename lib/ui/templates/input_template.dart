import 'package:flutter/material.dart';

class InputTemplate extends StatefulWidget {
  final String city;
  final ValueChanged setCity;
  final String title;
  const InputTemplate({super.key, required this.city, required this.setCity, required this.title});

  @override
  State<InputTemplate> createState() => _InputTemplateState();
}

class _InputTemplateState extends State<InputTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: (value) {
            widget.setCity(value);
        },
        style: Theme.of(context).textTheme.titleMedium,
        initialValue: widget.city,
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Theme.of(context).focusColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
      ),
    );
  }
}
