import 'package:file_picker/file_picker.dart';

class PickerFiles {
  PickerFiles._();
  static pickImage() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    return result;
  }

  static pickIMediaFiles() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'mp4']);
    return result;
  }
}
