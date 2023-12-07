import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareController extends GetxController {
  Future<void> shareText(String text) async {
    await Share.share(text);
    update();
  }
}
