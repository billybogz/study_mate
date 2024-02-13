import 'dart:io';

extension FileExtension on File {
  Future<double> get getFileSizeInMB async {
    final FileStat fileStat = await stat();
    final int fileSizeInBytes = fileStat.size;
    final double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB;
  }
}
