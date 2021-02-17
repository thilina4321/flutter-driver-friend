import 'package:driver_friend/model/service-model.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewServiceScreen extends StatefulWidget {
  static String routeName = 'create-new-service';

  @override
  _CreateNewServiceScreenState createState() => _CreateNewServiceScreenState();
}

class _CreateNewServiceScreenState extends State<CreateNewServiceScreen> {
  final _form = GlobalKey<FormState>();

  SparePart _service = SparePart();
  bool isLoading = false;

  Future<void> _createService(context) async {
    bool isValid = _form.currentState.validate();
    if (isValid == false) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ServiceCenterProvider>(context, listen: false)
          .addService(_service);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(ServiceCenterList.routeName);
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
                    onPressed: () => _createService(context),
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
