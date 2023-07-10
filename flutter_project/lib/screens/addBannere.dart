import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../providers/banner_prov.dart';
import 'addImage_screen.dart';
import 'adminBanner_Screen.dart';

class addBanner extends StatefulWidget {
  const addBanner({Key? key}) : super(key: key);

  @override
  State<addBanner> createState() => _addBannerState();
}

class _addBannerState extends State<addBanner> {
  File? image = null;
  var width;
  var height;

  TextEditingController _url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Select Image"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.browse_gallery),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                width: width,
                height: height * .2,
                child: image != null
                    ? Image.file(
                        image!,
                        width: width,
                        height: height * 0.2,
                        fit: BoxFit.fill,
                      )
                    : const Icon(
                        (Icons.image),
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _url,
              decoration: InputDecoration(
                label: const Text(" Image URL"),
                hintText: "ADD URL",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 270,
            ),
            CustButton(
                buttonText: "Save",
                onTap: () async {
                  Provider.of<BannerProv>(context, listen: false)
                      .addNewBanner(image: image!, url: _url.text);
                  Navigator.pop(context);
                }),
          ],
        ),
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
