import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/is-perform.dart';
import 'package:driver_friend/model/part.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/spare_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/sparePartShop/add-part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpareShopItems extends StatefulWidget {
  static String routeName = 'spare-shop-items';

  @override
  _SpareShopItemsState createState() => _SpareShopItemsState();
}

class _SpareShopItemsState extends State<SpareShopItems> {
  bool isLoading = false;

  var me;

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;

    return Scaffold(
        appBar: AppBar(
          title: Text('Items'),
        ),
        body: FutureBuilder(
          future: Provider.of<SpareShopProvider>(context, listen: false)
              .fetchParts(me['id']),
          builder: (context, items) {
            if (items.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (items.error != null) {
              if (items.error.toString().contains('404')) {
                return Text('No items found yet');
              }

              return Text('Sorry something went wrong');
            }

            return Consumer<SpareShopProvider>(
              builder: (context, service, child) {
                List<SparePart> parts = service.spareParts;
                return parts.length == 0
                    ? Center(
                        child: Text('No items yet'),
                      )
                    : ListView.builder(
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
                                  if (parts[index].image != null)
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: Image.network(
                                        parts[index].image,
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
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Rs.' + parts[index].price.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      if (me['role'] == 'sparePartShop')
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                CreateNewPartScreen.routeName,
                                                arguments: parts[index].id);
                                          },
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                      if (me['role'] == 'sparePartShop')
                                        FlatButton(
                                          onPressed: () async {
                                            try {
                                              bool isPerform =
                                                  await IsPerformDialog
                                                      .performStatus(context);
                                              if (isPerform)
                                                setState(() {
                                                  isLoading = true;
                                                });
                                              if (isPerform)
                                                await Provider.of<
                                                            SpareShopProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteParts(
                                                        parts[index].id);
                                              if (isPerform)
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
        ));
  }
}
