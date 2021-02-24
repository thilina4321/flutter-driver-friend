import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:driver_friend/screen/sparePartShop/spare_shop_items.dart';
import 'package:flutter/material.dart';
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
    try {
      await Provider.of<SpareShopProvider>(context, listen: false)
          .addParts(_part);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(SpareShopItems.routeName);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Item'),
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
                FlatButton(
                  child: Text('Attach image'),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
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
                            'Create',
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
