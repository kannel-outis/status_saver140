import 'package:flutter/material.dart';
import '../../ui/screens/main_screen/main_screen_viewModel.dart';

class AppBarW extends StatelessWidget implements PreferredSizeWidget {
  final MainScreenViewModel model;
  final PageController pageController;

  const AppBarW({Key key, this.model, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            child: Row(children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  pageController.animateToPage(0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: model.index != 1
                        ? Border.all(color: Colors.white)
                        : Border(),
                  ),
                  child: Center(
                    child:
                        Text("Status", style: TextStyle(color: Colors.white)),
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: model.index == 1
                        ? Border.all(color: Colors.white)
                        : Border(),
                  ),
                  child: Center(
                    child: Text("Saved Status",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              )),
              // Expanded(child: Text("Status")),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
