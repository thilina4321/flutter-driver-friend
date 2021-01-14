import 'package:flutter/material.dart';

class DefaultQuestionScreen extends StatefulWidget {
  static String routeName = '/default-quiz';

  @override
  _DefaultQuestionScreenState createState() => _DefaultQuestionScreenState();
}

class _DefaultQuestionScreenState extends State<DefaultQuestionScreen> {
  List quiz = [
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/faq.jpg',
                fit: BoxFit.cover,
              ),
              title: Text(
                'Frequently Ask Questions',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).accentColor),
                  ),
                  child: FlatButton(
                    padding: const EdgeInsets.all(0),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/faq_q.jpg',
                            fit: BoxFit.cover,
                          ),
                          margin: const EdgeInsets.all(20),
                          height: 70,
                          width: 70,
                        ),
                        Expanded(
                          child: Text(
                            quiz[index],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: quiz.length,
            ),
          ),
        ],
      ),
    );
  }
}
