import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:status_saver140/ui/screens/main_screen/permission_handler.dart';
import '../../../ui/widgets/appBar.dart';
import '../../../ui/screens/page_view_screens/saved_images_screen.dart';
import '../../../ui/screens/page_view_screens/status_images_screen.dart';
import 'main_screen_viewModel.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainScreenViewModel>.reactive(
      viewModelBuilder: () => MainScreenViewModel(),
      onModelReady: (model) {
        model.getPermit();
      },
      fireOnModelReadyOnce: true,
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBarW(
              model: model,
              pageController: _pageController,
            ),
            body: Container(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  model.pageChange(index);
                },
                children: [
                  StatusImagesScreen(
                    model: model,
                  ),
                  SavedImagesScreen(model: model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
