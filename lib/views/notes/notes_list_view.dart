
import 'package:flutter/material.dart';
import 'package:testingapp/services/crud/notes_service.dart';
import 'package:testingapp/utilities/dialogs/delete_dialog.dart';

typedef DeleteNoteCallBack = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final DeleteNoteCallBack onDeleteNote;
  const NotesListView({
    Key? key, 
    required this.notes, 
    required this.onDeleteNote
    }) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          title: Text(
            note.text,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () async {
                final shoulDelete = await showDeleteDialog(context);
                if (shoulDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete)),
        );
      },
    );
  }
}