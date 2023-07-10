import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../custButton.dart';
import '../providers/banner_prov.dart';

class addImage extends StatefulWidget {
  const addImage({Key? key}) : super(key: key);

  @override
  State<addImage> createState() => _addImageState();
}

class _addImageState extends State<addImage> {
  TextEditingController _url = TextEditingController();
  File? image = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          image != null
              ? Image.file(
                  image!,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.fill,
                )
              : const SizedBox(
                  height: 10,
                ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt)),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image_rounded)),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          CustButton(
              buttonText: "Save",
              onTap: () {
                Provider.of<BannerProv>(context, listen: false)
                    .addNewBanner(image: image!, url: _url.text);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source: imageSource);
    if (xImage != null) {
      image = File(xImage.path);
      setState(() {});
    }
  }
}
