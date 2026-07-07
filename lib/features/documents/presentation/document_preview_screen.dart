import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/document.dart';

class DocumentPreviewScreen extends StatelessWidget {
  final Document document;

  const DocumentPreviewScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final isPdf = document.filePath.toLowerCase().endsWith('.pdf');
    final file = File(document.filePath);
    final fileExists = file.existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(document.name),
        actions: [
          if (fileExists)
            IconButton(
              icon: const Icon(LucideIcons.share2),
              onPressed: () {
                SharePlus.instance.share(ShareParams(
                  files: [XFile(document.filePath)],
                  text: 'Sharing document: ${document.name}',
                ));
              },
            ),
        ],
      ),
      body: !fileExists
          ? const Center(
              child: Text('File not found'),
            )
          : isPdf
              ? PDFView(
                  filePath: document.filePath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onError: (error) {
                    debugPrint(error.toString());
                  },
                  onPageError: (page, error) {
                    debugPrint('$page: ${error.toString()}');
                  },
                )
              : Center(
                  child: InteractiveViewer(
                    child: Image.file(file),
                  ),
                ),
    );
  }
}
