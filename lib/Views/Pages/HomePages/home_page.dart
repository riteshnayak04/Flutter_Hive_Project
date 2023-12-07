import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hive_project/Constants/Boxes/boxes.dart';
import 'package:flutter_hive_project/Models/notes_model.dart';
import 'package:flutter_hive_project/Views/Pages/add_note_page.dart';
import 'package:flutter_hive_project/Views/Pages/HomePages/note_details_page.dart';
import 'package:flutter_hive_project/Views/Pages/note_edit_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLongPress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notes App',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getNotes().listenable(),
          builder: (context, boxValue, child) {
            var data = boxValue.values.toList().cast<NotesModel>();
            return ListView.builder(
              itemCount: boxValue.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 15, right: 10),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text(
                            'Are you sure you want to delete this note?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final box = Boxes.getNotes();
                                box.deleteAt(index);
                                Get.back();
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onTap: () {
                    Get.to(
                      transition: Transition.rightToLeft,
                      () => NoteDetailsPage(),
                      arguments: data[index],
                    );
                  },
                  title: Text(
                    data[index].title!,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    data[index].description!,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: data[index].imagePath != null &&
                            data[index].imagePath!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.file(
                              File(data[index].imagePath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.image_outlined,
                            color: Colors.grey,
                          ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(
                        transition: Transition.rightToLeft,
                        () => NoteEditPage(),
                        arguments: data[index],
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 1.0,
        onPressed: () {
          Get.to(
            transition: Transition.rightToLeft,
            () => const AddNotePage(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
    );
  }
}
