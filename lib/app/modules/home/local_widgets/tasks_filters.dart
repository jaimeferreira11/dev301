import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class TaskFilter extends StatelessWidget {
  const TaskFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'radio-group',
        builder: (_) => SizedBox(
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Radio(
                          value: 'all',
                          groupValue: _.filterBy.toString(),
                          onChanged: (String? value) => _.changeFilter(value)),
                      const Text('Ninguna')
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Radio(
                          value: "high",
                          groupValue: _.filterBy.toString(),
                          onChanged: (String? value) => _.changeFilter(value)),
                      const Text("Alta")
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Radio(
                          value: 'medium',
                          groupValue: _.filterBy.toString(),
                          onChanged: (String? value) => _.changeFilter(value)),
                      const Text('Media')
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Radio(
                          value: 'low',
                          groupValue: _.filterBy.toString(),
                          onChanged: (String? value) => _.changeFilter(value)),
                      const Text('Baja')
                    ],
                  )
                ],
              ),
            ));
  }
}
