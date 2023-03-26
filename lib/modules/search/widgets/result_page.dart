import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('You have selected the word:'),
          GestureDetector(
            onTap: () {
              // Returns this.query as result to previous screen, c.f.
              // `showSearch()` above.
              //this.close(context, this.query);
            },
            child: Text(
              "Result Page",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
