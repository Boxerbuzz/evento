import 'package:flutter/material.dart';

import 'avatar.dart';

class FacePile extends StatefulWidget {
  const FacePile({
    Key? key,
    required this.urls,
    this.faceSize = 48,
    this.facePercentOverlap = 0.5,
  }) : super(key: key);

  final List<String> urls;
  final double faceSize;
  final double facePercentOverlap;

  @override
  _FacePileState createState() => _FacePileState();
}

class _FacePileState extends State<FacePile>
    with SingleTickerProviderStateMixin {
  final _visibleAvatars = <String>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _syncAvatarsWithPile();
    });
  }

  @override
  void didUpdateWidget(FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _syncAvatarsWithPile();
    });
  }

  void _syncAvatarsWithPile() {
    setState(() {
      final newAvatars = widget.urls.where(
        (avatar) => _visibleAvatars
            .where((visibleAvatar) => visibleAvatar == avatar)
            .isEmpty,
      );

      for (final newAvatar in newAvatars) {
        _visibleAvatars.add(newAvatar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final facesCount = _visibleAvatars.length;

        double facePercentVisible = 1.0 - widget.facePercentOverlap;

        final maxIntrinsicWidth = facesCount > 1
            ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize
            : widget.faceSize;

        late double leftOffset;
        if (maxIntrinsicWidth > constraints.maxWidth) {
          leftOffset = 0;
          //(constraints.maxWidth - maxIntrinsicWidth) / 2
          facePercentVisible =
              ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
        } else {
          leftOffset = 0;
        }

        if (constraints.maxWidth < widget.faceSize) {
          // There isn't room for a single face. Show nothing.
          return const SizedBox();
        }

        return SizedBox(
          height: widget.faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < facesCount; i += 1)
                AnimatedPositioned(
                  key: ValueKey(_visibleAvatars[i]),
                  top: 0,
                  height: widget.faceSize,
                  left: leftOffset + (i * facePercentVisible * widget.faceSize),
                  width: widget.faceSize,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: EvAvatar(
                    url: _visibleAvatars[i],
                    showFace: widget.urls.contains(_visibleAvatars[i]),
                    faceSize: widget.faceSize,
                    onDisappear: () {
                      setState(() => _visibleAvatars.removeAt(i));
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
