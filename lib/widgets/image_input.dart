import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();
  File? _storedImage;



  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 212,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Picture'),
          ),
        )
      ],
    );
  }

  Future<void> _takePicture() async {
    try {
      final imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 636,
        maxHeight: 360,
      );
      if (imageFile == null) return;
      setState(() {
        _storedImage = File(imageFile.path.toString());
      });
      final fileName = path.basename(imageFile.path);
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      await imageFile.saveTo('${appDir.path}/$fileName');
      final savedImage = File('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      final LostDataResponse response = await _picker.retrieveLostData();
      if (response.file != null || response.files != null) {
        setState(() {
          _storedImage = File(response.file!.path);
        });

        final appDir = await syspaths.getApplicationDocumentsDirectory();
        final fileName = path.basename(response.file!.path);
        final File savedImage = await response.file!.saveTo('${appDir.path}/$fileName') as File;
        widget.onSelectImage(savedImage);
      } else {
        if (kDebugMode) {
          print('could not retrieve data');
        }
      }
    }
  }
}
