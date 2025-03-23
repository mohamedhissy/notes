import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notetest/features/home/presentation/view/add_notes.dart';

import '../controller/note_controller.dart';

class NoteView extends StatelessWidget {
  final controller = Get.put(NoteController());

  void _showNoteDialog(
      {String? id, String? initialTitle, String? initialContent}) {
    controller.titleController.text = initialTitle ?? '';
    controller.contentController.text = initialContent ?? '';

    Get.defaultDialog(
      title: id == null ? 'Add Note' : 'Edit Note',
      content: Column(
        children: [
          TextField(
            controller: controller.titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: controller.contentController,
            decoration: InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      onConfirm: () {
        final title = controller.titleController.text.trim();
        final content = controller.contentController.text.trim();

        if (title.isNotEmpty && content.isNotEmpty) {
          if (id == null) {
            controller.addNote(title, content);
          } else {
            controller.updateNote(id, title, content);
          }
        }
        Get.back(); // Close dialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNotes()),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNoteDialog(),
          ),
        ],
      ),
      body: Obx(() {
        final notes = controller.notes;

        if (notes.isEmpty) {
          return Center(child: Text('No notes available.'));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10, // Space between columns
            mainAxisSpacing: 10, // Space between rows
          ),
          padding: EdgeInsets.all(10),
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return Container(
              width: 250,
              height: 250,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.cyan,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.title),
                      SizedBox(
                        height: 20,
                      ),
                      Text(note.content),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.deleteNote(note.id),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          // Prevent unnecessary scrolling
          physics: NeverScrollableScrollPhysics(),
        );
      }),
    );
  }
}

// ListView.builder(
// itemCount: notes.length,
// itemBuilder: (context, index) {
// final note = notes[index];
// return Card(
// margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// child: ListTile(
// title: Text(note.title),
// subtitle: Text(note.content),
// trailing: Row(
// mainAxisSize: MainAxisSize.min,
// children: [
// IconButton(
// icon: Icon(Icons.edit, color: Colors.orange),
// onPressed: () => _showNoteDialog(
// id: note.id,
// initialTitle: note.title,
// initialContent: note.content,
// ),
// ),
// IconButton(
// icon: Icon(Icons.delete, color: Colors.red),
// onPressed: () => controller.deleteNote(note.id),
// ),
// ],
// ),
// ),
// );
// },
// );
