import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/moudels/shop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/catigores_image.dart';
import '../providers/categories_prov.dart';
import '../providers/shop_prov.dart';
import 'addImage_screen.dart';

class Edit_shop extends StatefulWidget {
  Shop edit_shop;
  Edit_shop({required this.edit_shop});
  @override
  State<Edit_shop> createState() => _Edit_shopState();
}

class _Edit_shopState extends State<Edit_shop> {
  File? image = null;
  var width;
  var height;
  Shop? selectedValue;

  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _imgage_url = TextEditingController();
  TextEditingController _id_state_type = TextEditingController();

  String dropdownValue = 'DisActive';
  var Id_statustypes;
  var Id_category;
  var name;

  CategoriesModel? select_value;
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProv>(context, listen: false).getCategoriesAdmin();
    _id.text = widget.edit_shop.id;
    _imgage_url.text = widget.edit_shop.imageURL;
    _name.text = widget.edit_shop.name;
    _id_state_type.text = widget.edit_shop.Id_stateType;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
              child: image != null
                  ? Image.file(
                      image!,
                    )
                  : Image.network(
                      ConsValues.BASEURL + widget.edit_shop.imageURL,
                      width: 350,
                    ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                label: const Text(" Shop Name"),
                hintText: "ADD Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _id_state_type,
              decoration: InputDecoration(
                label: const Text(" Shop _id_state_type"),
                hintText: "ADD _id_state_type",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              items: <String>['Active', 'DisActive']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  print("jsonBody = $newValue");
                  dropdownValue = newValue!;
                });
                if (dropdownValue == "DisActive") {
                  Id_statustypes = "2";
                } else {
                  Id_statustypes = "1";
                }
              },
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Category Name:$name',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Consumer<CategoryProv>(
                  builder: (context, value, child) {
                    return DropdownButton<CategoriesModel>(
                      value: select_value,
                      items: value.listCategoriesModelAdmin
                          .map<DropdownMenuItem<CategoriesModel>>(
                              (CategoriesModel value) {
                        return DropdownMenuItem<CategoriesModel>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (CategoriesModel? Value) {
                        setState(() {
                          select_value = Value;
                          Id_category = select_value!.id;
                          name = select_value!.name;
                          print("selectedValue = $name");
                          print("Value = $Id_category");
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustButton(
      //   buttonText: "Save",
      //   onTap: () async {
      //     await Provider.of<ShopProv>(context, listen: false).Updateshop(
      //         image: image!,
      //         name: _name.text,
      //         Id: _id.text,
      //         Id_statustype: _id_state_type.text);
      //     Navigator.pop(context);
      //   },
      // ),
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
