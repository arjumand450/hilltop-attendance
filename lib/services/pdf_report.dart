import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../providers/report_provider.dart';


Future<String> exportReportPdf(List<DayTotal> days) async {
  final now = DateTime.now();
  final fileName = 'report_${DateFormat('yyyyMMdd').format(now)}.pdf';

  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Hilltop Guest House - Attendance Report',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Text('Date: ${DateFormat('d MMMM yyyy').format(now)}'),
          pw.Text('Present today: ${days.isEmpty ? 0 : days.last.count}'),
          pw.SizedBox(height: 16),
          pw.Text('Last 7 days',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headers: ['Date', 'Staff present'],
            data: [
              for (final d in days)
                [DateFormat('d MMM yyyy').format(d.day), d.count.toString()],
            ],
          ),
        ],
      ),
    ),
  );

  await Printing.sharePdf(bytes: await doc.save(), filename: fileName);
  return fileName;
}