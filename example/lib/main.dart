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
                Placeholder(
                  strokeWidth: 0.5,
                  color: Colors.grey,
                ),
                if (_background != null) Image.file(_background),
                ElevatedButton(
                  child: Text("Select Background Asset"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => _createSelectImageDialog(
                        title: "Select Background Asset",
                        onGetImage: (image) {
                          setState(() {
                            _background = image;
                          });
                        },
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
                if (_sticker != null) Image.file(_sticker),
                ElevatedButton(
                  child: Text("Select Sticker Asset"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => _createSelectImageDialog(
                        title: "Select Sticker Asset",
                        onGetImage: (image) {
                          setState(() {
                            _sticker = image;
                          });
                        },
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
                if (_topColor != null) Container(color: _topColor),
                ElevatedButton(
                  child: Text("Select Top Color"),
                  onPressed: () async {
                    final Color color = await showDialog(
                      context: context,
                      builder: (context) => _createSelectColorDialog(
                        title: "Select Top Color",
                        colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                          Colors.yellow,
                          Colors.cyan,
                        ],
                      ),
                    );

                    if (color != null) {
                      setState(() {
                        _topColor = color;
                      });
                    }
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
                if (_bottomColor != null) Container(color: _bottomColor),
                ElevatedButton(
                  child: Text("Select Bottom Color"),
                  onPressed: () async {
                    final Color color = await showDialog(
                      context: context,
                      builder: (context) => _createSelectColorDialog(
                        title: "Select Bottom Color",
                        colors: [
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                          Colors.yellow,
                          Colors.cyan,
                        ],
                      ),
                    );

                    if (color != null) {
                      setState(() {
                        _bottomColor = color;
                      });
                    }
                  },
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
              onPressed: _background != null || _sticker != null ? () {} : null,
            ),
          ),
        )
      ],
    );
  }

  Widget _createSelectImageDialog({
    String title,
    void onGetImage(File image),
  }) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text(title),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text("Gallery"),
              onPressed: () async {
                final image = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                Navigator.of(context).pop();
                onGetImage(image);
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text("Camera"),
              onPressed: () async {
                final image = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                Navigator.of(context).pop();
                onGetImage(image);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createSelectColorDialog({
    String title,
    List<Color> colors,
  }) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          SizedBox(height: 8),
          Row(
            children: [
              for (final color in colors) _createColorItem(color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createColorItem(Color color) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(color);
        },
        child: Container(
          height: 50,
          color: color,
        ),
      ),
    );
  }
}
