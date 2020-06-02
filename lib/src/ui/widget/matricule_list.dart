import 'package:flutter/material.dart';
import 'package:mawqif/src/providers/vehicule_provider/vehicule_provider.dart';
import 'package:provider/provider.dart';

import 'itemtile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final vehicule = new Vehicule(immatriculation: "qshdkqd");
    //Provider.of<VehiculeProvider>(context).list.add(vehicule);
    return Consumer<VehiculeProvider>(
      builder: (context, taskData, child) { if(taskData.list.isNotEmpty){ return         ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.list[index];
            return ItemTile(
              taskTitle: "ggggdhzehfiozejfiel",
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.update(task);
              },
              longPressCallback: () {
                taskData.delete(task);
              },
            );
          },
          itemCount: taskData.list.length,
        ); } else {return  Container(child: Text("HELOOO"),); }
      }
    );
  }
}
      