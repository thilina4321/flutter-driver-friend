import 'dart:io';

import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_services.dart';
import 'package:driver_friend/widget/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateNewServiceScreen extends StatefulWidget {
  static String routeName = 'create-new-service';

  @override
  _CreateNewServiceScreenState createState() => _CreateNewServiceScreenState();
}

class _CreateNewServiceScreenState extends State<CreateNewServiceScreen> {
  final _form = GlobalKey<FormState>();

  Service _service = Service();
  bool isLoading = false;
  final picker = ImagePicker();
  var img;
  var imagePrev;

  Future getImage() async {
    var pickedFile;

    try {
      pickedFile =
          await PickImageFromGalleryOrCamera.getProfileImage(context, picker);
      if (pickedFile != null) {
        setState(() {
          _service.image = pickedFile.path;
          imagePrev = File(pickedFile.path);
          isImageEdit = true;
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      ErrorDialog.errorDialog(context, e.toString());
    }
  }

  bool isImageEdit = false;

  Future<void> _createService(context) async {
    bool isValid = _form.currentState.validate();
    if (isValid == false) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    _service.shopId = me['id'];
    try {
      await Provider.of<ServiceCenterProvider>(context, listen: false)
          .addService(_service, service.id, isImageEdit);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context)
          .pushReplacementNamed(ServiceCenterServices.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.toString(),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  var me;
  @override
  void initState() {
    me = Provider.of<UserProvider>(context, listen: false).me;
    super.initState();
  }

  Service service = Service();

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      Service editableService =
          Provider.of<ServiceCenterProvider>(context).selectServiceForEdit(id);

      if (editableService != null) {
        service = editableService;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Service'),
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
                    _service.name = val;
                  },
                  initialValue: service != null ? service.name : null,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Service name required';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Service Name',
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    _service.description = val;
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Service description required';
                    }

                    return null;
                  },
                  initialValue: service.description,
                  decoration: InputDecoration(
                    labelText: 'Service Description',
                  ),
                ),
                TextFormField(
                  onSaved: (val) {
                    _service.price = val;
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Service price required';
                    }

                    return null;
                  },
                  initialValue: service.price,
                  decoration: InputDecoration(
                    labelText: 'Service Price',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text('Image'),
                  onPressed: getImage,
                ),
                SizedBox(
                  height: 20,
                ),
                if (id != null && isImageEdit == false)
                  Container(
                    height: 200,
                    child: Image.network(
                      service.image,
                      fit: BoxFit.cover,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                if (imagePrev != null)
                  Container(
                    height: 200,
                    child: Image.file(
                      imagePrev,
                      fit: BoxFit.cover,
                    ),
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
                    onPressed: () => _createService(context),
                    color: Colors.purple,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            service.id == null ? 'Create' : 'Update',
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
