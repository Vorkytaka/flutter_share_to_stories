import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share_to_stories/share_to_stories.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

const List<Color> INSTAGRAM_GRADIENT = [
  Color(0xff405de6),
  Color(0xff5851db),
  Color(0xff833ab4),
  Color(0xffc13584),
  Color(0xffe1306c),
  Color(0xfffd1d1d),
];

const List<Color> SELECTABLE_COLORS = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.cyan,
];

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
            ColorSelectorWidget(
              title: "Select Top Color",
              color: _topColor,
              onSelected: (color) {
                setState(() {
                  _topColor = color;
                });
              },
            ),
            ColorSelectorWidget(
              title: "Select Bottom Color",
              color: _bottomColor,
              onSelected: (color) {
                setState(() {
                  _bottomColor = color;
                });
              },
            ),
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
            // for button with gradient colors thanks to the `bonnyz
            // https://stackoverflow.com/a/58417424
            child: RaisedButton(
              onPressed: _background != null || _sticker != null
                  ? () {
                      final backgroundUri =
                          _background != null ? _background.uri : null;
                      final stickerUri = _sticker != null ? _sticker.uri : null;
                      _shareToTheInstagram(
                        backgroundAssetUri: backgroundUri,
                        stickerAssetUri: stickerUri,
                        topColor: _topColor,
                        bottomColor: _bottomColor,
                      );
                    }
                  : null,
              padding: const EdgeInsets.all(0.0),
              child: Ink(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: INSTAGRAM_GRADIENT,
                  ),
                ),
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 88.0,
                    minHeight: 36.0,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Share to the Instagram',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
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

  Future<void> _shareToTheInstagram({
    Uri backgroundAssetUri,
    Uri stickerAssetUri,
    Color topColor,
    Color bottomColor,
  }) async {
    ShareToStories.shareToInstagram(
      backgroundAssetUri: backgroundAssetUri,
      stickerAssetUri: stickerAssetUri,
      topColor: topColor,
      bottomColor: bottomColor,
    );
  }
}

typedef void OnColorSelected(Color color);

class ColorSelectorWidget extends StatelessWidget {
  final String title;
  final Color color;
  final OnColorSelected onSelected;

  const ColorSelectorWidget({
    Key key,
    this.title,
    this.color,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Placeholder(
          strokeWidth: 0.5,
          color: Colors.grey,
        ),
        if (color != null) Container(color: color),
        ElevatedButton(
          child: Text(title),
          onPressed: () async {
            final Color color = await showDialog(
              context: context,
              builder: (context) => _createSelectColorDialog(
                context: context,
                title: title,
                colors: SELECTABLE_COLORS,
              ),
            );

            onSelected(color);
          },
        ),
      ],
    );
  }

  Widget _createSelectColorDialog({
    BuildContext context,
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
              for (final color in colors) _createColorItem(context, color),
              // item for remove selected color
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(null);
                  },
                  child: SizedBox(
                    height: 50,
                    child: Placeholder(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createColorItem(
    BuildContext context,
    Color color,
  ) {
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
