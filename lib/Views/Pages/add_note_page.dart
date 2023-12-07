import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hive_project/Controller/add_note_controller.dart';
import 'package:flutter_hive_project/Models/notes_model.dart';
import 'package:get/get.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    final AddNoteController controller = Get.put(AddNoteController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                NotesModel notesModel = NotesModel(
                  title: controller.titleController.text,
                  description: controller.subtitleController.text,
                  imagePath: controller.imageFilePath!.value,
                );
                controller.addNotes(notesModel);
                print('### 1.Note title: ${notesModel.title}');
                print('### 2.Note description: ${notesModel.description}');
                print('### 3.Note image path: ${notesModel.imagePath}');
                Get.back();
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          Form(
            key: controller.formKey,
            child: Obx(() {
              return Column(
                children: [
                  // image picker
                  if (controller.imageFilePath!.value.isNotEmpty)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Builder(
                              builder: (context) {
                                return Image.file(
                                  File(controller.imageFilePath!.value),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Image.file(
                          File(controller.imageFilePath!.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () async {
                        await controller.pickImage();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    controller: controller.titleController,
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
                    controller: controller.subtitleController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'Subtitle',
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
