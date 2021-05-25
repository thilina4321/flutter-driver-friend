import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/is-perform.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyQuestionsScrenn extends StatefulWidget {
  static String routeName = 'driver_my_question';

  @override
  _MyQuestionsScrennState createState() => _MyQuestionsScrennState();
}

class _MyQuestionsScrennState extends State<MyQuestionsScrenn> {
  bool loading = false;

  Future deleteQuestion(context, id) async {
    try {
      bool type = await IsPerformDialog.performStatus(context);
      if (type) {
        setState(() {
          loading = true;
        });
        await Provider.of<DriverProvider>(context, listen: false)
            .deleteMyQuestion(id);
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      ErrorDialog.errorDialog(context, e.toString());
    }
  }

  var getData;
  var me;
  @override
  void initState() {
    me = Provider.of<UserProvider>(context, listen: false).me;
    getData = Provider.of<DriverProvider>(context, listen: false)
        .fetchMyQuestions(me['id']);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: loading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text('My Questions'),
        ),
        body: FutureBuilder(
          future: getData,
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (data.error != null) {
              if (data.error.toString().contains('404')) {
                return Center(child: Text('No Questions yet..'));
              }
              return Center(child: Text('Sorry something went wrong'));
            }

            return Consumer<DriverProvider>(
              builder: (context, questioons, child) {
                List quiz = questioons.myquiz;

                return ListView.builder(
                    itemCount: quiz.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(quiz[index]['question']),
                                ),
                                RaisedButton(
                                  color: Colors.red,
                                  onPressed: () => deleteQuestion(
                                      context, quiz[index]['id']),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 10,
                              color: Colors.black,
                            )
                          ],
                        ),
                      );
                    });
              },
            );
          },
        ));
  }
}
