import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_strings.dart';
import '../controller/note_controller.dart';
import '../model/note_model.dart';

class AddNotes extends StatelessWidget {

  final NoteModel? note;

  const AddNotes({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoteController>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
          appBar: AppBar(
            title: TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            child: TextField(
              controller: controller.contentController,
              decoration: InputDecoration(
                hintText: ManagerStrings.enterEmail,
                hintStyle:
                TextStyle(color: ManagerColors.bgColorTextFieldString),
                filled: true,
                fillColor: ManagerColors.bgColorTextField,
              ),
              expands: true,
              maxLines: null,
            ),
          ),
        );
      }
    );
  }
}
