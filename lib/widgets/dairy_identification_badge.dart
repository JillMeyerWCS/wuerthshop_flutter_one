import 'package:flutter/material.dart';

class DairyIdentificationBadge extends StatelessWidget {
  final TextEditingController controller;

  const DairyIdentificationBadge({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline5;
    return SizedBox(
        width: 220,
        child: Center(
            child: Container(
          width: 180,
          height: 120,
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.elliptical(120, 80))),
          child: DefaultTextStyle.merge(
            style: textStyle,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("DE"),
              TextField(
                textAlign: TextAlign.center,
                style: textStyle,
                controller: controller,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: "App. Nr."),
              ),
              const Text("EG")
            ]),
          ),
        )));
  }
}
