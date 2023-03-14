import 'dart:io';
import 'dart:typed_data';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasvat/services/datastore_services.dart';
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

enum UploadState {
  progressing,
  success,
  failure,
}

class _ImageUploadButtonWidgetState extends State<ImageUploadButtonWidget> {
  String? _imageName;
  String? _imagePath;
  Uint8List? _imageBytes;
  UploadState _uploadState = UploadState.failure;
  int _progressPercent = 0;

  void uploadProgress(TransferProgress progress) {
    double progressPercent = (progress.totalBytes - progress.currentBytes) *
        100 /
        progress.totalBytes;

    int per = progressPercent.toInt();
    setState(() {
      _progressPercent = per;
    });
  }

  Future<void> _uploadImage() async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery).then(
        (XFile? pickedImage) async {
          if (pickedImage != null) {
            // set file name
            _imageName = pickedImage.name;
            _imagePath = pickedImage.path;
            // SET BYTES TO IMAGE VARIABLE
            _imageBytes = await pickedImage.readAsBytes();
            // UPLOAD IMAGE TO AMPLIFY STORAGE
            setState(() {
              _imageName = pickedImage.name;
              _imageBytes;
              _uploadState = UploadState.progressing;
            });
            await DatastoreServices.createAndUploadFile(_imageBytes!,
              (progress) {
              uploadProgress(progress);
            }, uploadPath: widget.uploadPath, path: _imagePath!)
                .then((value) {
              setState(() {
                _uploadState = UploadState.success;
              });
            });
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _uploadState = UploadState.failure;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          content: const Center(
            child: Text(
              'Something Went Wrong. Try again',
              style: TextStyle(
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _showImageDialog() {
    return Dialog(
      child: Column(
        children: [
          Align(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel,
              ),
            ),
          ),
          Image.memory(_imageBytes!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_uploadState == UploadState.failure)
          DottedBorder(
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
          ),
        if (_uploadState == UploadState.progressing)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_progressPercent',
                  style: TextStyle(
                    color: text400,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  'uploading image $_imageName',
                  softWrap: true,
                  style: TextStyle(
                    color: text400,
                    fontSize: body2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        if (_uploadState == UploadState.success)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    _uploadImage();
                  },
                  icon: Icon(
                    Icons.image,
                    color: accent2,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 15),
                TextButton(
                  onPressed: () {
                    _showImageDialog();
                  },
                  child: Text(
                    '$_imageName',
                    softWrap: true,
                    style: TextStyle(
                      color: text400,
                      fontSize: body2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: DELETE IMAGE
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
