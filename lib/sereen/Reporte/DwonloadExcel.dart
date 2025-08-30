import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportSystemReport(Map<String, dynamic> report,String name) async {
  try {
    var excel = Excel.createExcel();
    Sheet sheet = excel['${name} Report'] ?? excel['Sheet1']!;

    // العناوين
    sheet.appendRow([
      TextCellValue("Metric"),
      TextCellValue("Value"),
    ]);

    // البيانات
    report.forEach((key, value) {
      sheet.appendRow([
        TextCellValue(key.toString()),
        TextCellValue(value.toString()),
      ]);
    });

    // حفظ الملف
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = "${dir.path}/system_report.xlsx";

    File file = File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    print("✅ Report saved at $filePath");

    // مشاركة الملف
    await Share.shareXFiles([XFile(filePath)], text: 'System Report');
  } catch (e) {
    print("❌ Error exporting report: $e");
  }
}

