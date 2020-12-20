import 'package:flutter/material.dart';

typedef void OnColorSelected(Color color);

class ColorSelectorWidget extends StatelessWidget {
  static const List<Color> SELECTABLE_COLORS = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.cyan,
  ];

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
