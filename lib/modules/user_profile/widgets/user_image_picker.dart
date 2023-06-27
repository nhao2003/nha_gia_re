import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  final bool isUploading;
  final String url;

  const UserImagePicker(this.imagePickFn, this.isUploading, this.url, {super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  void _pickImageFromFile() async {
    final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 60, maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(File(_pickedImage!.path));
    }
  }

  void _pickImageFromCamera() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 60, maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(File(_pickedImage!.path));
    }
  }

  void _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Center(
                  child: SizedBox(
                    height: 4.0,
                    width: 32.0,
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: _pickImageFromCamera,
              child: const ListTile(
                leading: Icon(Icons.camera_alt_outlined),
                title: Text('Chụp ảnh'),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: _pickImageFromFile,
              child: const ListTile(
                leading: Icon(Icons.folder_outlined),
                title: Text('Chọn ảnh'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: _pickImage,
            child: CircleAvatar(
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage!) : NetworkImage(widget.url) as ImageProvider,
              radius: 60,
            ),
          ),
          if (widget.isUploading) const SizedBox(width: 120, height: 120,child: CircularProgressIndicator()) ,
          Transform.translate(
            offset: const Offset(0, 10),
            child: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}
