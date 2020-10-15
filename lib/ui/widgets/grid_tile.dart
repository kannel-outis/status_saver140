import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../../ui/screens/main_screen/main_screen_viewModel.dart';
import '../../ui/widgets/page_route.dart';

class CustomGridTile extends StatelessWidget {
  final int index;
  final String path;
  final String name;
  final String modified;
  final String size;
  final bool isSaved;
  final MainScreenViewModel model;

  const CustomGridTile({
    this.index,
    this.path,
    this.model,
    this.name,
    this.modified,
    this.size,
    this.isSaved = false,
    Key key,
  }) : super(key: key);

  Widget bottomModal() {
    return Container(
      height: 300,
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Text(
              "Image Info",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Name : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Path : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  path,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Modified : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  modified,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Size : ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  size,
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          isSaved == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Share.shareFiles([path]);
                          },
                          child: Icon(
                            Icons.share,
                            size: 25,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                HeroPageRoute(
                  pageBuilder: (context) {
                    return Center(
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: isSaved == true ? (index + 100) : index,
                        child: Container(
                          child: InteractiveViewer(
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              fadeInCurve: Curves.easeInToLinear,
                              placeholder: AssetImage("assets/material.jpg"),
                              image: FileImage(File(path)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: isSaved == true ? (index + 100) : index,
                      child: Container(
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeInToLinear,
                          placeholder: AssetImage("assets/material.jpg"),
                          image: FileImage(File(path)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: -10,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                      isSaved == false ? Icons.file_download : Icons.delete,
                      color: Colors.yellow),
                  onPressed: () {
                    if (isSaved == false) {
                      model.saveStatus(path);
                    } else if (isSaved == true) {
                      print(true);
                      model.deleteSavedStatus(path, index);
                    }
                  }),
            ),
          ),
          Positioned(
            top: 0,
            right: 25,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.info, color: Colors.blue),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return bottomModal();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
