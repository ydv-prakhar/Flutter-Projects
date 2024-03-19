import 'package:flutter/material.dart';
import 'package:notes/components/note_settings.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/note_data_page.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function() onEditPressed;
  final void Function() onDeletePressed;
  final Note note;
  const NoteTile(
      {required this.onDeletePressed,
      required this.onEditPressed,
      required this.text,
      required this.note,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notedatapage(note: note))).then((value) => {
                  debugPrint("*******************************************************Came from note"),
                  
                });
          },
          title: Text(text),
          trailing: Builder(builder: (context) {
            return IconButton(
                onPressed: () => showPopover(
                    backgroundColor: Theme.of(context).colorScheme.background,
                    height: 100,
                    width: 100,
                    context: context,
                    bodyBuilder: (context) => NoteSettings(
                        onDeleteTap: onDeletePressed,
                        onEditTap: onEditPressed)),
                icon: const Icon(Icons.more_vert));
          })),
    );
  }
}
