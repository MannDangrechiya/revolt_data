import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/widgets/not_found_widget.dart';
import '../data/documents_provider.dart';

class DocumentPreviewScreen extends ConsumerWidget {
  final String documentId;

  const DocumentPreviewScreen({super.key, required this.documentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docAsync = ref.watch(documentByIdProvider(documentId));

    return docAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Document Preview')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => NotFoundWidget(
        message: 'Error loading document: $err',
        returnRoute: '/documents',
      ),
      data: (document) {
        if (document == null) {
          return const NotFoundWidget(
            message: 'Document not found or deleted.',
            returnRoute: '/documents',
          );
        }

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
  },
);
  }
}
