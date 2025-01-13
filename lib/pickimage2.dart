import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pick2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> _onImageButtonPressed(
      ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await ImagePicker().getImage(
        source: source,
        maxWidth: 2048.0,
        maxHeight: 2048.0,
      );

      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        print('Image file picked:');
        // Do something with imageBytes if needed
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Center(
        child: Text(
          'You have not yet picked an image.',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onImageButtonPressed(ImageSource.gallery, context);
        },
        heroTag: 'image0',
        tooltip: 'Pick Image from gallery',
        child: const Icon(Icons.photo_library),
      ),
    );
  }
}
