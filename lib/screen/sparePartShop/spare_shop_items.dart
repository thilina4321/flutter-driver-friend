import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpareShopItems extends StatefulWidget {
  static String routeName = 'spare-shop-items';

  @override
  _SpareShopItemsState createState() => _SpareShopItemsState();
}

class _SpareShopItemsState extends State<SpareShopItems> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<SpareShopProvider>(context, listen: false).fetchParts(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (data.error != null) {
            if (data.error.toString().contains('404')) {
              return Center(child: Text('No parts have yet'));
            }
            return Center(
              child: Text(
                'Something went wrong, please try again later',
              ),
            );
          }
          return Consumer<SpareShopProvider>(
            builder: (context, service, child) {
              List<SparePart> parts = service.spareParts;
              return ListView.builder(
                  itemCount: parts.length,
                  itemBuilder: (ctx, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            if (parts[index].image == null)
                              Container(
                                height: 200,
                                child: Image.asset(
                                  'assets/images/ser_cover.PNG',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              parts[index].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(parts[index].description),
                            ),
                            if (isLoading) CircularProgressIndicator(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    parts[index].price.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                FlatButton(
                                  onPressed: () async {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await Provider.of<ServiceCenterProvider>(
                                              context,
                                              listen: false)
                                          .deleteService(parts[index].id);
                                      setState(() {
                                        isLoading = false;
                                      });
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
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
