import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class BackupService {
  Future<String> backupDatabase() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, 'kirana_erp.sqlite'));

    if (!await dbFile.exists()) {
      throw Exception("Database file not found.");
    }

    final backupFolder =
        await getExternalStorageDirectory(); // Android specific downloads/documents dir
    // On Windows, you can prompt the user for a path using file_picker
    final backupPath = p.join(
      backupFolder!.path,
      'kirana_erp_backup_\${DateTime.now().millisecondsSinceEpoch}.sqlite',
    );

    await dbFile.copy(backupPath);
    return backupPath;
  }

  Future<void> restoreDatabase(String backupFilePath) async {
    final backupFile = File(backupFilePath);
    if (!await backupFile.exists()) {
      throw Exception("Backup file not found.");
    }

    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, 'kirana_erp.sqlite'));

    // Overwrite existing database
    await backupFile.copy(dbFile.path);
  }
}
