import 'package:flutter/material.dart';

class DefaultQuestionScreen extends StatelessWidget {
  static String routeName = 'default-quiz';
  final List quiz = [
    'Why is my check engine light on',
    'How do i check my engine oil level',
    'How often should i chage oil',
    'How do i change a tier',
    'How do i change my car battery',
    'How do i increase fuel efficiency',
    'How do i check the coolant level',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Frequently Ask Questions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              context: context,
              builder: (ctx) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to the Search option in FAQ section',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search',
                        ),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Serach',
                            style: TextStyle(
                              color: Colors.purple,
                            ),
                          ))
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.search),
      ),
      body: ListView.builder(
          itemCount: quiz.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 3,
              child: ListTile(
                title: Text(quiz[index]),
                trailing: FlatButton(
                  child: Text('Go', style: TextStyle(color: Colors.purple)),
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        // backgroundColor: Colors.white,
                        context: context,
                        builder: (ctx) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          quiz[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                      Icon(
                                        Icons.grass_outlined,
                                        size: 30,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Text(
                                    'This page is under construction...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            );
          }),
    );
  }
}
