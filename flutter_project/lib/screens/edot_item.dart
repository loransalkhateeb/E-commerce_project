import 'package:flutter/material.dart';
import 'package:flutter_project/moudels/item_model.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/item_model.dart';
import '../moudels/shop.dart';
import '../providers/items_prov.dart';
import '../providers/shop_prov.dart';

import '../const_values.dart';
import '../moudels/banner_images.dart';
import '../providers/banner_prov.dart';
import 'addBannere.dart';
import 'addImage_screen.dart';
import 'editBanner.dart';

class edit_item extends StatefulWidget {
  ItemModel item_model;
  edit_item({required this.item_model});

  @override
  State<edit_item> createState() => _edit_itemState();
}

class _edit_itemState extends State<edit_item> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];
  File? image = null;
  String dropdownValue = 'DisActive';
  Shop? selectedValue;
  TextEditingController _image_url = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _id_statetype = TextEditingController();
  TextEditingController _id_shops = TextEditingController();
  var Id_statustypes;
  var Id_shop;
  var Id_item;
  var name;

  void initState() {
    super.initState();
    _image_url.text = widget.item_model.ImageURL;
    _id.text = widget.item_model.Id;
    _name.text = widget.item_model.Name;
    _price.text = widget.item_model.Price.toString();
    _description.text = widget.item_model.Description;
    _id_statetype.text = widget.item_model.Id_statetype;
    _id_shops.text = widget.item_model.Id_shops;
    Provider.of<ItemProv>(context, listen: false).getItemsAdmin();
    Provider.of<ShopProv>(context, listen: false).getShopAdmin();
  }

  @override
  Widget build(BuildContext context) {
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
                ConsValues.BASEURL + widget.item_model.ImageURL,
                width: 350,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                label: const Text(" Item Name"),
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
              controller: _description,
              decoration: InputDecoration(
                label: const Text(" Item Description"),
                hintText: "ADD Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _price,
              decoration: InputDecoration(
                label: const Text(" Item Price"),
                hintText: "ADD Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _id_shops,
              decoration: InputDecoration(
                label: const Text(" Item id_shops"),
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
              controller: _id_statetype,
              decoration: InputDecoration(
                label: const Text(" Item id_statustype"),
                hintText: "ADD Name",
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
                  'Shop Name:$name',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Consumer<ShopProv>(
                  builder: (context, value, child) {
                    return DropdownButton<Shop>(
                      value: selectedValue,
                      items: value.listShopAdmin
                          .map<DropdownMenuItem<Shop>>((Shop value) {
                        return DropdownMenuItem<Shop>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (Shop? Value) {
                        setState(() {
                          selectedValue = Value;
                          Id_shop = selectedValue!.id;
                          name = selectedValue!.name;
                          print("selectedValue = $name");
                          print("Value = $Id_shop");
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
      bottomNavigationBar: CustButton(
        buttonText: "Save",
        onTap: () async {
          await Provider.of<ItemProv>(context, listen: false).addNewItems(
            image: image!,
            name: _name.text,
            description: _description.text,
            price: _price.text,
            Id_statustypes: Id_statustypes,
            Id_shop: Id_shop,
            listImages: imagefiles,
          );
          Navigator.pop(context);
        },
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
