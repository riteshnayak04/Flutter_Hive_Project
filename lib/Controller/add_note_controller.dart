import 'package:flutter/material.dart';
import 'package:flutter_hive_project/Constants/Boxes/boxes.dart';
import 'package:flutter_hive_project/Models/notes_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNoteController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  // image picker
  RxString? imageFilePath = ''.obs;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFilePath!.value = image.path;
      update();
    }
  }

  // add notes
  void addNotes(NotesModel notesModel) {
    final box = Boxes.getNotes();
    box.add(notesModel);
    notesModel.save();
  }
}
