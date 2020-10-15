import 'package:flutter/material.dart';
import '../../../ui/widgets/grid_tile.dart';
import '../../../ui/screens/main_screen/main_screen_viewModel.dart';

class StatusImagesScreen extends StatefulWidget {
  final MainScreenViewModel model;

  const StatusImagesScreen({Key key, this.model}) : super(key: key);
  @override
  _StatusImagesScreenState createState() => _StatusImagesScreenState();
}

class _StatusImagesScreenState extends State<StatusImagesScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: Colors.grey,
        child: widget.model.isPermitted == true
            ? GridView.builder(
                controller: _controller,
                addAutomaticKeepAlives: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: widget.model.statusList.length,
                itemBuilder: (context, index) {
                  return CustomGridTile(
                    index: index,
                    model: widget.model,
                    modified: widget.model.statusList[index].modified,
                    name: widget.model.statusList[index].name,
                    path: widget.model.statusList[index].path,
                    size: widget.model.statusList[index].size,
                  );
                },
              )
            : Container());
  }

  @override
  bool get wantKeepAlive => true;
}
