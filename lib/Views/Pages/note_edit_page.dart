// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hive_project/Controller/edit_note_controller.dart';
import 'package:flutter_hive_project/Models/notes_model.dart';
import 'package:flutter_hive_project/Views/Pages/HomePages/home_page.dart';
import 'package:get/get.dart';

class NoteEditPage extends StatelessWidget {
  NotesModel notesModel = Get.arguments;
  NoteEditPage({Key? key}) : super(key: key);

  EditNoteController noteEditController = Get.put(EditNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              NotesModel notesModel = NotesModel(
                title: noteEditController.titleController.text,
                description: noteEditController.descriptionController.text,
              );
              noteEditController.editNote(
                notesModel,
              );
              // navigate to home page
              Get.offAll(() => const HomePage());
            },
            child: const Text(
              'Update',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Form(
            key: noteEditController.formKey,
            child: Column(
              children: [
                notesModel.imagePath != null && notesModel.imagePath!.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Builder(
                                builder: (context) {
                                  return Image.file(
                                    File(notesModel.imagePath!),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.file(
                              File(notesModel.imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                        ),
                      ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  controller: noteEditController.titleController
                    ..text = notesModel.title!,
                  maxLines: 2,
                  maxLength: 100,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter subtitle';
                    }
                    return null;
                  },
                  controller: noteEditController.descriptionController
                    ..text = notesModel.description!,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Subtitle',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
