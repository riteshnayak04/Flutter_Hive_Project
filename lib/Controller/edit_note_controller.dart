import 'package:flutter/material.dart';
import 'package:flutter_hive_project/Constants/Boxes/boxes.dart';
import 'package:flutter_hive_project/Models/notes_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EditNoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void editNote(NotesModel notesModel) {
    final box = Boxes.getNotes();
    box.add(notesModel);
    notesModel.save();
  }
}
