import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/widgets/select_photo.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/porcelana_options.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  List<File> _imageFiles = [];

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File img = File(image.path);
      img = (await _cropImage(imageFile: img))!;
      setState(() {
        Provider.of<PorcelanaOptions>(context, listen: false).addFile(img);
        Provider.of<PorcelanaOptions>(context, listen: false)
            .addFilePath(img.path);
      });
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path, uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Kadrowanie',
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Kadrowanie',
      )
    ]);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  void initState() {
    super.initState();
    _imageFiles =
        Provider.of<PorcelanaOptions>(context, listen: false).getFiles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
                items: _imageFiles.map((item) {
                  return Builder(builder: (BuildContext context) {
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image.file(
                                item,
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.contain,
                              ),
                              IconButton(
                                onPressed: () => {
                                  setState(
                                    () {
                                      Provider.of<PorcelanaOptions>(context,
                                              listen: false)
                                          .removeFile(item);
                                      Provider.of<PorcelanaOptions>(context,
                                              listen: false)
                                          .removeFilePath(item.path);
                                    },
                                  )
                                },
                                icon: const Icon(Icons.cancel),
                                color: MyColors.accentMaterial,
                              ),
                            ]),
                      ),
                    ]);
                  });
                }).toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9,
                )),
            const SizedBox(
              height: 10,
            ),
            SelectPhoto(
                textLabel: 'Dodaj zdjęcie z galerii',
                icon: Icons.image,
                onTap: () => _pickImage(ImageSource.gallery)),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'lub',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SelectPhoto(
                textLabel: 'Zrób zdjęcie',
                icon: Icons.camera,
                onTap: () => _pickImage(ImageSource.camera)),
          ]),
    ));
  }
}
