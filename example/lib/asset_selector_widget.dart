import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnAssetSelected(File asset);

class AssetSelectorWidget extends StatelessWidget {
  final String title;
  final File asset;
  final OnAssetSelected onSelected;

  const AssetSelectorWidget({
    Key key,
    this.title,
    this.asset,
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
        if (asset != null) Image.file(asset),
        ElevatedButton(
          child: Text(title),
          onPressed: () async {
            final asset = await showDialog(
              context: context,
              builder: (context) => _createSelectImageDialog(
                context: context,
                title: title,
              ),
            );
            onSelected(asset);
          },
        ),
      ],
    );
  }

  Widget _createSelectImageDialog({
    BuildContext context,
    String title,
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
                final asset = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                Navigator.of(context).pop(asset);
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              child: Text("Camera"),
              onPressed: () async {
                final asset = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                Navigator.of(context).pop(asset);
              },
            ),
          ),
        ],
      ),
    );
  }
}
