import 'dart:typed_data';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_constants.dart';

class ImageUploadButtonWidget extends StatefulWidget {
  final String uploadPath, title;
  const ImageUploadButtonWidget({
    Key? key,
    required this.uploadPath,
    required this.title,
  }) : super(key: key);

  @override
  State<ImageUploadButtonWidget> createState() =>
      _ImageUploadButtonWidgetState();
}

class _ImageUploadButtonWidgetState extends State<ImageUploadButtonWidget> {
  String? _imageName;
  Uint8List? _imageBytes;

  Future<void> _uploadImage() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery).then(
        (XFile? pickedImage) async {
          if (pickedImage != null) {
            // TODO: UPLOAD IMAGE TO AMPLIFY STORAGE
            // set file name
            _imageName = pickedImage.name;
            // SET BYTES TO IMAGE VARIABLE
            _imageBytes = await pickedImage.readAsBytes();
            await AmplifyAuthCognito().getCurrentUser().then((user) {
              user.userId;
            });
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _showImageDialog(Uint8List image) {
    return Dialog(
      child: Column(
        children: [
          Align(
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel,
                )),
          ),
          Image.memory(image),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [10, 1],
      strokeCap: StrokeCap.butt,
      strokeWidth: 1.0,
      radius: const Radius.circular(10),
      color: accent2,
      child: GestureDetector(
        onTap: () async {
          await _uploadImage();
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: accent2,
                size: 32,
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Add your ${widget.title} Card image',
                    style: TextStyle(
                      color: text400,
                      fontSize: body2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'supports: JPG, JPEG, PNG',
                    style: TextStyle(
                      color: text300,
                      fontSize: caption,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
