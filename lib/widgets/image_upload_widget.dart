import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_constants.dart';

class ImageUploadButtonWidget extends StatefulWidget {
  final String uploadPath, title;
  final int? maxSize;
  final Function(XFile? image) onUploaded;
  const ImageUploadButtonWidget({
    Key? key,
    this.maxSize,
    required this.uploadPath,
    required this.title,
    required this.onUploaded,
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

  // void uploadProgress(TransferProgress progress) {
  //   double progressPercent = (progress.totalBytes - progress.currentBytes) *
  //       100 /
  //       progress.totalBytes;
  //
  //   int per = progressPercent.toInt();
  //   setState(() {
  //     _progressPercent = per;
  //   });
  // }

  Future<void> _uploadImage() async {
    try {
      await ImagePicker().pickImage(
        source: ImageSource.gallery,
        
      ).then(
        (XFile? pickedImage) async {
          if (pickedImage == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No file chosen'))
            );
            return;
          }
          if ( File(pickedImage.path).lengthSync() / 1024 / 1024 > 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cannot attach file over 5 MB'))
            );
            return;
          }
          _imageName = pickedImage.name;
          _imagePath = pickedImage.path;
          // SET BYTES TO IMAGE VARIABLE
          _imageBytes = await pickedImage.readAsBytes();

          setState(() {
            _imageName;
            _imageBytes;
            _uploadState = UploadState.success;
          });
          widget.onUploaded(pickedImage);
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel,
                color: error,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: accent2)),
            child: Image.memory(
              _imageBytes!,
              fit: BoxFit.fill,
              height: 400,
              width: double.infinity,
            ),
          ),
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
          DottedBorder(
            dashPattern: const [10, 1],
            strokeCap: StrokeCap.butt,
            strokeWidth: 1.0,
            radius: const Radius.circular(10),
            color: accent2,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),

                  Image.memory(
                    _imageBytes!,
                    height: 28,
                    width: 28,
                  ),
                  // IconButton(
                  //   onPressed: () async {
                  //     _uploadImage();
                  //   },
                  //   icon: Icon(
                  //     Icons.image,
                  //     color: accent2,
                  //     size: 32,
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (ctx) {
                            return _showImageDialog();
                          });
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
                      setState(() {
                        _imageBytes = null;
                        _imageName = null;
                        _imagePath = null;
                        _uploadState = UploadState.failure;
                      });
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: error.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
