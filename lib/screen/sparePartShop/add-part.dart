import 'dart:io';

import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateNewPartScreen extends StatefulWidget {
  static String routeName = 'create-new-part';

  @override
  _CreateNewPartScreenState createState() => _CreateNewPartScreenState();
}

class _CreateNewPartScreenState extends State<CreateNewPartScreen> {
  final _form = GlobalKey<FormState>();

  bool isLoading = false;
  SparePart _part = SparePart();

  Future<void> _createPart(context) async {
    bool isValid = _form.currentState.validate();
    if (isValid == false) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    _part.shopId = me['id'];
    try {
      await Provider.of<SpareShopProvider>(context, listen: false)
          .addParts(_part, id);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(SpareShopItems.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ErrorDialog.errorDialog(context, 'Sorry something went wrong.');
    }
  }

  final picker = ImagePicker();
  var partImage;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        partImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  var me;
  var id;
  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;
    id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      SparePart editable =
          Provider.of<SpareShopProvider>(context, listen: false)
              .selectSpareForEdit(id);
      _part = editable;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('New Spare part'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  onSaved: (val) {
                    _part.name = val;
                  },
                  initialValue: _part.name,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Part name required';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Part Name',
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    _part.description = val;
                  },
                  initialValue: _part.description,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Part description required';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Part Description',
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    _part.price = val;
                  },
                  initialValue: _part.price,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Service price required';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Service Price',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.integration_instructions_outlined),
                  label: Text('Attach image'),
                  onPressed: getImage,
                ),
                SizedBox(
                  height: 20,
                ),
                if (partImage != null)
                  Container(
                    child: Image.file(
                      partImage,
                      fit: BoxFit.cover,
                    ),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: RaisedButton(
                    padding: const EdgeInsets.all(10),
                    onPressed: () => _createPart(context),
                    color: Colors.purple,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            id != null ? 'Update' : 'Create',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
