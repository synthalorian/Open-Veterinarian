import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
import '../../services/database_service.dart';

class BackupService {
  static Future<void> exportBackup() async {
    final dir = await getApplicationDocumentsDirectory();

    // In a real app, you would use 'archive' package to zip.
    // For now, we will just share the main Hive files.
    final List<XFile> filesToShare = [];
    
    final entities = dir.listSync();
    for (var entity in entities) {
      if (entity is File && (entity.path.endsWith('.hive') || entity.path.endsWith('.lock'))) {
        filesToShare.add(XFile(entity.path));
      }
    }

    if (filesToShare.isNotEmpty) {
      await Share.shareXFiles(filesToShare, text: 'Open Veterinarian Database Backup');
    }
  }

  static Future<bool> importBackup() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any, // .hive files aren't a standard type
    );

    if (result != null && result.files.isNotEmpty) {
      // Close boxes before replacing files
      await Hive.close();

      final dir = await getApplicationDocumentsDirectory();
      for (var file in result.files) {
        if (file.path != null && (file.name.endsWith('.hive') || file.name.endsWith('.lock'))) {
          final newFile = File('${dir.path}/${file.name}');
          await File(file.path!).copy(newFile.path);
        }
      }

      // Re-initialize after import
      await DatabaseService.init();
      return true;
    }
    return false;
  }
}
