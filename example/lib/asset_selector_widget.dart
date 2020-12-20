import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnAssetSelected(File asset);

class AssetSelectorWidget extends StatelessWidget {
  static final ImagePicker _imagePicker = ImagePicker();

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
          _createSelector(context, "Gallery", ImageSource.gallery),
          _createSelector(context, "Camera", ImageSource.camera),
        ],
      ),
    );
  }

  Widget _createSelector(
    BuildContext context,
    String title,
    ImageSource source,
  ) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        child: Text(title),
        onPressed: () async {
          final selectedAsset = await _imagePicker.getImage(source: source);
          File asset;
          if (selectedAsset != null) {
            asset = File(selectedAsset.path);
          } else {
            asset = null;
          }
          Navigator.of(context).pop(asset);
        },
      ),
    );
  }
}
