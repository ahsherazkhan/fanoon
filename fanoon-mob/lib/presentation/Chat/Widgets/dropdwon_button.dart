import 'package:flutter/material.dart';

const List<String> choices = <String>['Delete', 'Archive', 'Mute'];

class MyDropDownButton extends StatefulWidget {
  const MyDropDownButton({Key? key}) : super(key: key);

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 3.2,
      icon: const Icon(Icons.more_vert,color: Colors.grey),
      onSelected: (value) {
        if(value == 'Delete'){
          //TODO: Perform delete operation of the message.
        }else if(value == 'Archive'){

        }else if(value == 'Mute'){

        }
      },
      itemBuilder: (BuildContext context) {
        return choices.map((choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(
              choice,
              style: Theme.of(context).textTheme.labelMedium
            ),
          );
        }).toList();
      },
    );
  }
}
