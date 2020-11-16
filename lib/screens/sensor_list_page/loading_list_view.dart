import 'package:flutter/material.dart';
import 'package:lorapark_app/screens/widgets/data_presenter/loading_data_presenter.dart';

class LoadingListView extends StatelessWidget {
  final int itemCount;

  LoadingListView({@required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: LoadingDataPresenter(
            height: MediaQuery.of(context).size.width * 0.45,
          ),
        ),
      ),
    );
  }
}
