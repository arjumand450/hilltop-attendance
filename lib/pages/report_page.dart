import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/report_provider.dart';
import '../services/pdf_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    // Load after the first frame so notifyListeners is not called during build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final report = context.watch<ReportProvider>();
    final days = report.days;
    final maxCount = days.isEmpty
        ? 5
        : days.map((d) => d.count).reduce((a, b) => a > b ? a : b);
    final maxY = (maxCount < 5 ? 5 : maxCount + 1).toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Report')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: report.isLoading && days.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Text(
                    'Last 7 days',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 260,
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        alignment: BarChartAlignment.spaceAround,
                        gridData: const FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              reservedSize: 28,
                              getTitlesWidget: (v, meta) => Text(
                                v.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (v, meta) {
                                final i = v.toInt();
                                if (i < 0 || i >= days.length) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    DateFormat('d MMM').format(days[i].day),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        barGroups: [
                          for (int i = 0; i < days.length; i++)
                            BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: days[i].count.toDouble(),
                                  width: 18,
                                  color: Colors.primaries[
                                      (i * 2) % Colors.primaries.length],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Load time: ${report.loadSeconds.toStringAsFixed(2)} s'),

                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export PDF'),
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      try {
                        final file = await exportReportPdf(report.days);
                        messenger.showSnackBar(
                          SnackBar(content: Text('Saved: ${file.path}')),
                        );
                      } catch (e) {
                        messenger.showSnackBar(
                          SnackBar(content: Text('Could not save PDF: $e')),
                        );
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}