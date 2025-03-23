import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/note_model.dart';
import '../view/add_notes.dart';

class NoteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  void fetchNotes() {
    _firestore
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      notes.value = snapshot.docs
          .map((doc) => NoteModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addNote(String title, String content) async {
    await _firestore.collection('notes').add({
      'title': title,
      'content': content,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> updateNote(String id, String title, String content) async {
    await _firestore.collection('notes').doc(id).update({
      'title': title,
      'content': content,
    });
  }

  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }

  void createNote({String? id}) {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      if (id != null) {
        updateNote(id, title, content);
      } else {
        addNote(title, content);
      }
      Get.back();
    }
  }

  void clearTextField({NoteModel? note}) {
    if (note != null) {
      titleController.text = note.title;
      contentController.text = note.content;
    } else {
      titleController.clear();
      contentController.clear();
    }

    Get.to(() => AddNotes(note: note));
  }
}
