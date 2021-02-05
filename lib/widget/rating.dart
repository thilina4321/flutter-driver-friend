import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingWidget extends StatefulWidget {
  static String routeName = 'rating';
  @override
  _CustomRatingWidgetState createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  final _form = GlobalKey<FormState>();
  String initialValue = '0';
  double rating;

  _saveRating() {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();
    print(initialValue);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    rating = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Rate Me',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.green,
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              Text(rating.toString()),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: TextFormField(
                    onSaved: (value) {
                      if (value == '') {
                        value = '0';
                      }
                      initialValue = value;
                    },
                    validator: (value) {
                      if (value == '') {
                        value = '0';
                      }
                      if (double.parse(value) < 1 || double.parse(value) > 5) {
                        return 'Rate should between 1-5';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Rating',
                      suffixIcon: FlatButton(
                        onPressed: _saveRating,
                        child: Text('Rate'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
