import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/drawer.dart';
import 'package:notes/components/note_tile.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // create note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    if(textController.text.trim()!=""){
                    context.read<NoteDatabase>().addNote(textController.text);
                    }
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                )
              ],
            ));
  }

  void updateNote(Note note) {
    textController.text = note.title;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Update Note"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNotes(note.id, textController.text);
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text("Update"),
                ),
              ],
            ))
            .then((value)=>{
              textController.clear()
            });
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  // read note
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update note

  // delete  note

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child:  Text("Notes",
            style: GoogleFonts.dmSerifText(fontSize:48, color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[currentNotes.length-index-1];
                  return NoteTile(text: note.title, onEditPressed:() => updateNote(note), onDeletePressed: ()=>deleteNote(note.id), note:note);
                }),
          ),
        ],
      ),
    );
  }
}
