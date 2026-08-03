import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image_picker/image_picker.dart';

import '../data/documents_provider.dart';
import '../domain/document.dart';

class DocumentAddScreen extends ConsumerStatefulWidget {
  const DocumentAddScreen({super.key});

  @override
  ConsumerState<DocumentAddScreen> createState() => _DocumentAddScreenState();
}

class _DocumentAddScreenState extends ConsumerState<DocumentAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedCategory = 'RC';
  final List<String> _categories = [
    'RC',
    'Insurance',
    'Invoice',
    'Warranty',
    'ServiceBill',
    'Licence',
    'Custom'
  ];

  File? _selectedFile;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool fromCamera) async {
    try {
      if (fromCamera) {
        final picker = ImagePicker();
        final image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          setState(() {
            _selectedFile = File(image.path);
          });
        }
      } else {
        final result = await FilePicker.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        );
        if (result != null && result.files.single.path != null) {
          setState(() {
            _selectedFile = File(result.files.single.path!);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e')),
        );
      }
    }
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please attach a document file or photo.')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Copy file to local app directory
      final appDir = await getApplicationDocumentsDirectory();
      final docsDir = Directory(p.join(appDir.path, 'documents'));
      if (!await docsDir.exists()) {
        await docsDir.create(recursive: true);
      }
      
      final ext = p.extension(_selectedFile!.path);
      final filename = '${DateTime.now().millisecondsSinceEpoch}$ext';
      final savedFile = await _selectedFile!.copy(p.join(docsDir.path, filename));

      final doc = Document(
        name: _nameController.text.trim(),
        category: _selectedCategory,
        filePath: savedFile.path,
        uploadDate: DateTime.now(),
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );

      await ref.read(documentsProvider.notifier).addDocument(doc);
      
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save document: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Attachment Area
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(LucideIcons.camera),
                            title: const Text('Take Photo'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickFile(true);
                            },
                          ),
                          ListTile(
                            leading: const Icon(LucideIcons.fileImage),
                            title: const Text('Choose File/Image'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickFile(false);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedFile == null
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: _selectedFile != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: _selectedFile!.path.toLowerCase().endsWith('.pdf')
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(LucideIcons.fileText, size: 48, color: Theme.of(context).colorScheme.primary),
                                          const SizedBox(height: 8),
                                          const Text('PDF Document Selected'),
                                        ],
                                      ),
                                    )
                                  : Image.file(_selectedFile!, fit: BoxFit.cover),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton.filledTonal(
                                icon: const Icon(LucideIcons.x, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _selectedFile = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.uploadCloud,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to add document\n(Image or PDF)',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
              
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Document Name',
                  hintText: 'e.g. Active Insurance 2024',
                  prefixIcon: Icon(LucideIcons.type),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(LucideIcons.tag),
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(LucideIcons.alignLeft),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 32),
              
              SizedBox(
                height: 56,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : _saveDocument,
                  icon: _isSaving 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(LucideIcons.save),
                  label: Text(_isSaving ? 'Saving...' : 'Save Document', style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
