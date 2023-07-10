import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/custButton.dart';
import 'package:flutter_project/moudels/banner_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/banner_prov.dart';
import 'addImage_screen.dart';

class editBanner extends StatefulWidget {
  BannerImages bannerImages;
  editBanner({required this.bannerImages});

  @override
  State<editBanner> createState() => _editBannerState();
}

class _editBannerState extends State<editBanner> {
  TextEditingController _url = TextEditingController();
  void initState() {
    super.initState();
    _url.text = widget.bannerImages.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return addImage();
                    },
                  ),
                );
              },
              child: Image.network(
                ConsValues.BASEURL + widget.bannerImages.imageURL,
                width: 350,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextField(
              controller: _url,
              decoration: InputDecoration(
                label: const Text("URL"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 370,
            ),
            CustButton(
                buttonText: "Save",
                onTap: () async {
                  Provider.of<BannerProv>(context, listen: false)
                      .addNewBanner(image: image!, url: _url.text);
                  Navigator.pop(context);
                }),
            Text(
              widget.bannerImages.id,
              style: TextStyle(color: Colors.green, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  File? image = null;
  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source: imageSource);
    if (xImage != null) {
      image = File(xImage.path);
      setState(() {});
    }
  }
}
