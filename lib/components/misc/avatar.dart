import 'package:evento/exports.dart';
import 'package:flutter/material.dart';

class EvAvatar extends StatefulWidget {
  const EvAvatar({
    Key? key,
    required this.url,
    required this.faceSize,
    required this.showFace,
    required this.onDisappear,
  }) : super(key: key);

  final String url;
  final double faceSize;
  final bool showFace;
  final VoidCallback onDisappear;

  @override
  _EvAvatarState createState() => _EvAvatarState();
}

class _EvAvatarState extends State<EvAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onDisappear();
        }
      });
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimationWithWidget();
  }

  @override
  void didUpdateWidget(EvAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimationWithWidget();
  }

  void _syncScaleAnimationWithWidget() {
    if (widget.showFace &&
        !_scaleController.isCompleted &&
        _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.faceSize,
      height: widget.faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.faceSize,
                height: widget.faceSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  image: DecorationImage(image: NetworkImage(widget.url)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EvAltAvatar extends StatelessWidget {
  const EvAltAvatar(
    this.imgUrl, {
    this.email,
    this.size = 24,
    this.radius,
    Key? key,
  }) : super(key: key);
  final double size;
  final BorderRadius? radius;
  final String? imgUrl;
  final String? email;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        image: DecorationImage(
          image: NetworkImage(
            StringHelper.isEmpty(imgUrl) == true
                ? StringHelper.getAvatar(email)
                : imgUrl!,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: radius ?? BorderRadius.circular(30),
        boxShadow: Shadows.m(theme.grey, .1),
        border: Border.all(color: theme.primary, width: .9),
      ),
    );
  }
}
