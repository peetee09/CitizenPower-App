import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citizenpower/screens/location_screen.dart';
import 'package:citizenpower/widgets/media_preview.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _descriptionController = TextEditingController();
  final List<XFile> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _mediaFiles.add(image);
      });
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
              'Add photos/videos (optional):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            MediaPreview(files: _mediaFiles),
            IconButton(
              icon: const Icon(Icons.add_a_photo, size: 40),
              onPressed: _pickImage,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.push(
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