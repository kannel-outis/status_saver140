import 'package:flutter/material.dart';
import '../../../ui/widgets/grid_tile.dart';
import '../../../ui/screens/main_screen/main_screen_viewModel.dart';

class SavedImagesScreen extends StatefulWidget {
  final MainScreenViewModel model;

  const SavedImagesScreen({Key key, this.model}) : super(key: key);
  @override
  _SavedImagesScreenState createState() => _SavedImagesScreenState();
}

class _SavedImagesScreenState extends State<SavedImagesScreen>
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
                itemCount: widget.model.savedStatusList.length,
                itemBuilder: (context, index) {
                  return CustomGridTile(
                    index: index,
                    isSaved: true,
                    model: widget.model,
                    name: widget.model.savedStatusList[index].name,
                    modified: widget.model.savedStatusList[index].modified,
                    path: widget.model.savedStatusList[index].path,
                    size: widget.model.savedStatusList[index].size,
                  );
                },
              )
            : Container());
  }

  @override
  bool get wantKeepAlive => true;
}
