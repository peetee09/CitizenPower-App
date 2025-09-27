import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; // ADD for web file picking
import 'package:citizenpower/screens/location_screen.dart';
import 'package:citizenpower/widgets/media_preview.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _descriptionController = TextEditingController();
  final List<XFile> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia() async {
    if (kIsWeb) {
      // Web file picking
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (var file in result.files) {
            _mediaFiles.add(XFile(file.path!));
          }
        });
      }
    } else {
      // Mobile camera/gallery picking
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _mediaFiles.add(image);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Describe the issue:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Provide details about the problem...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Add photos (optional):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            MediaPreview(files: _mediaFiles),
            IconButton(
              icon: Icon(kIsWeb ? Icons.add_photo_alternate : Icons.add_a_photo, size: 40),
              onPressed: _pickMedia,
              tooltip: kIsWeb ? 'Upload photos' : 'Take photo',
            ),
            if (kIsWeb) 
              const Text(
                'Note: On web, you can upload existing photos from your device',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _descriptionController.text.isEmpty 
                  ? null 
                  : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationScreen(
                        description: _descriptionController.text,
                        mediaFiles: _mediaFiles,
                      ),
                    ),
                  ),
              child: const Text('Next: Location'),
            ),
          ],
        ),
      ),
    );
  }
}
