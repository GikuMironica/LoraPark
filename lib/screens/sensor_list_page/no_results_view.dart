import 'package:flutter/material.dart';

class NoResultsView extends StatelessWidget {
  final String query;

  NoResultsView({@required this.query});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            'No Results',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'There were no results for "$query".',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
