import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Share to Instagram stories"),
        ),
        body: SelectorWidget(),
      ),
    );
  }
}

class SelectorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  File _background;
  File _sticker;
  Color _topColor;
  Color _bottomColor;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      children: [
        GridView.count(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _background == null
                    ? Placeholder(
                        strokeWidth: 0.5,
                        color: Colors.grey,
                      )
                    : Image.file(_background),
                ElevatedButton(
                  child: Text("Select Background Asset"),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text("Gallery"),
                              onPressed: () async {
                                final image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                Navigator.of(context).pop();
                                setState(() {
                                  _background = image;
                                });
                              },
                            ),
                            ElevatedButton(
                              child: Text("Camera"),
                              onPressed: () async {
                                final image = await ImagePicker.pickImage(
                                  source: ImageSource.camera,
                                );
                                Navigator.of(context).pop();
                                setState(() {
                                  _background = image;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Placeholder(
                  strokeWidth: 0.5,
                  color: Colors.grey,
                ),
                ElevatedButton(
                  child: Text("Select Sticker Asset"),
                  onPressed: () {},
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Placeholder(
                  strokeWidth: 0.5,
                  color: Colors.grey,
                ),
                ElevatedButton(
                  child: Text("Select Top Color"),
                  onPressed: () {},
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Placeholder(
                  strokeWidth: 0.5,
                  color: Colors.grey,
                ),
                ElevatedButton(
                  child: Text("Select Bottom Color"),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              child: Text("SHARE TO INSTAGRAM"),
              onPressed: null,
            ),
          ),
        )
      ],
    );
  }
}
