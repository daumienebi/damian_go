import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// ignore_for_file: prefer_const_constructors

class UserSearchDelegateScreen extends SearchDelegate {
  //Add a hint text to override the default one
  final String? hintText;
  UserSearchDelegateScreen({required this.hintText});

  @override
  String? get searchFieldLabel => hintText;

  @override
  TextStyle get searchFieldStyle => TextStyle(
    fontSize: 16,
    color: Colors.grey[800],
  );

  @override
  TextInputType get keyboardType => TextInputType.name;

  @override
  TextInputAction get textInputAction => TextInputAction.search;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
        tooltip: 'Close',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); //close the search bar
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
      return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      return Container();
    //NOTE :  snapshot.data.length ~/ 2 (Integer truncate value).
    //Round up to the nearest int without remainders
  }

  Widget resultNotFoundWidget() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Lottie.asset(
          'assets/lottie_animations/search-not-found.json',
        ),
        const Text(
          'No results found.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, color: Colors.black87),
        ),
      ]),
    );
  }
}