import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../application/report_generator_service.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  bool _isDetailed = false;
  bool _isGenerating = false;
  String _selectedPreset = 'This Month';

  final List<String> _presets = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
    'This Year',
    'Custom'
  ];

  void _applyPreset(String preset) {
    final now = DateTime.now();
    setState(() {
      _selectedPreset = preset;
      switch (preset) {
        case 'Today':
          _startDate = DateTime(now.year, now.month, now.day);
          _endDate = now;
          break;
        case 'Yesterday':
          _startDate = DateTime(now.year, now.month, now.day - 1);
          _endDate = DateTime(now.year, now.month, now.day - 1, 23, 59, 59);
          break;
        case 'This Week':
          _startDate = now.subtract(Duration(days: now.weekday - 1));
          _endDate = now;
          break;
        case 'This Month':
          _startDate = DateTime(now.year, now.month, 1);
          _endDate = now;
          break;
        case 'This Year':
          _startDate = DateTime(now.year, 1, 1);
          _endDate = now;
          break;
      }
    });
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        _selectedPreset = 'Custom';
      });
    }
  }

  Future<void> _generateReport(String format) async {
    setState(() => _isGenerating = true);
    try {
      final service = ref.read(reportGeneratorServiceProvider.notifier);
      if (format == 'PDF') {
        final file = await service.generatePdfReport(_startDate, _endDate, _isDetailed);
        Share.shareXFiles([XFile(file.path)], text: 'Revolt Report (PDF)');
      } else if (format == 'Excel') {
        final file = await service.generateExcelReport(_startDate, _endDate);
        Share.shareXFiles([XFile(file.path)], text: 'Revolt Report (Excel)');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating report: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Reports'),
      ),
      body: _isGenerating
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text('Generating Report...', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Date Range', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _presets.map((preset) {
                      return ChoiceChip(
                        label: Text(preset),
                        selected: _selectedPreset == preset,
                        onSelected: (selected) {
                          if (selected) {
                            _applyPreset(preset);
                            if (preset == 'Custom') {
                              _pickDateRange();
                            }
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  
                  Card(
                    child: ListTile(
                      leading: const Icon(LucideIcons.calendar),
                      title: Text('${DateFormat.yMMMd().format(_startDate)} - ${DateFormat.yMMMd().format(_endDate)}'),
                      trailing: const Icon(LucideIcons.edit2),
                      onTap: _pickDateRange,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  const Text('Report Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  
                  SwitchListTile(
                    title: const Text('Detailed Report'),
                    subtitle: const Text('Include all individual logs'),
                    value: _isDetailed,
                    onChanged: (val) => setState(() => _isDetailed = val),
                    secondary: const Icon(LucideIcons.list),
                  ),
                  const SizedBox(height: 32),
                  
                  FilledButton.icon(
                    onPressed: () => _generateReport('PDF'),
                    icon: const Icon(LucideIcons.fileText),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Export to PDF', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  FilledButton.tonalIcon(
                    onPressed: () => _generateReport('Excel'),
                    icon: const Icon(LucideIcons.fileSpreadsheet),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Export to Excel', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
