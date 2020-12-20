import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share_to_stories/share_to_stories.dart';
import 'package:flutter_share_to_stories_example/asset_selector_widget.dart';
import 'package:flutter_share_to_stories_example/color_selector_widget.dart';

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
            AssetSelectorWidget(
              title: "Select Background Asset",
              asset: _background,
              onSelected: (asset) {
                setState(() {
                  _background = asset;
                });
              },
            ),
            AssetSelectorWidget(
              title: "Select Sticker Asset",
              asset: _sticker,
              onSelected: (asset) {
                setState(() {
                  _sticker = asset;
                });
              },
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
                  ? _shareToTheInstagram
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

  Future<void> _shareToTheInstagram() async {
    final backgroundUri = _background != null ? _background.uri : null;
    final stickerUri = _sticker != null ? _sticker.uri : null;

    ShareToStories.shareToInstagram(
      backgroundAssetUri: backgroundUri,
      stickerAssetUri: stickerUri,
      topColor: _topColor,
      bottomColor: _bottomColor,
    );
  }
}
