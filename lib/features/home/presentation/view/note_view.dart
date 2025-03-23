import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/note_controller.dart';

class NoteView extends StatelessWidget {
  final controller = Get.put(NoteController());
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(builder: (controller) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.clearTextField();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        appBar: AppBar(
          title: Text('Notes'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                controller.clearTextField();
              },
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        body: Obx(
          () {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: controller.notes.length,
                  itemBuilder: (context, index) {
                    final note = controller.notes[index];
                    return InkWell(
                      onTap: () {
                        controller.clearTextField(note: note);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    note.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.red, size: 20),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    controller.deleteNote(note.id);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                note.content,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      );
    });
  }
}
