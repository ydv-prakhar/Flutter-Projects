import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class Notedatapage extends StatefulWidget {
  final Note note;
  const Notedatapage({required this.note, super.key});

  @override
  State<Notedatapage> createState() => _NotedatapageState();
}

class _NotedatapageState extends State<Notedatapage> {
  final dataTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataTextController.text = widget.note.data;
    dataTextController.addListener(_onDataTextChanged); // Add listener here
  }

  @override
  void dispose() {
    dataTextController.dispose();
    super.dispose();
  }

  void _onDataTextChanged() {
    final newData = dataTextController.text;
    context.read<NoteDatabase>().updateData(widget.note.id, newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              Padding(
                padding: const EdgeInsets.only(left:25.0, right: 25.0),
                child: TextField(
                  controller: dataTextController,
                  decoration: const InputDecoration(
                    hintText: "Write your note here...",
                  ),
                  scrollPadding: const EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 99999,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
