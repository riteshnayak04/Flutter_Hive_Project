import 'package:flutter_hive_project/Conatants/Boxes/boxes.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  void deleteNotes(int index) {
    final box = Boxes.getNotes();
    box.deleteAt(index);
  }
}
