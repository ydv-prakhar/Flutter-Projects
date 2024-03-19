import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function() onDeleteTap;
  final void Function() onEditTap;

  const NoteSettings(
      {required this.onEditTap,required this.onDeleteTap,  super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
          Navigator.pop(context);
          onEditTap();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text(
              "Edit",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),
          ),
        ),
        GestureDetector(
          onTap: (){
            onDeleteTap();
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.background,
            child: Center(
                child: Text("Delete",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary))),
          ),
        )
      ],
    );
  }
}
