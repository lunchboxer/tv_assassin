import 'package:flutter/material.dart';
import 'package:tv_assassin/ui/skull_icon.dart';

class AssassinButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isTransmitting;

  const AssassinButton({
    super.key,
    required this.onPressed,
    this.isTransmitting = false,
  });

  @override
  State<AssassinButton> createState() => _AssassinButtonState();
}

class _AssassinButtonState extends State<AssassinButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.95, // 5% scale down
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Button dimensions: minHeight = 20% screen height
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Semantics(
        label: 'Power off nearby televisions',
        button: true,
        enabled: !widget.isTransmitting,
        child: GestureDetector(
          onTapDown: widget.isTransmitting ? null : _onTapDown,
          onTapUp: widget.isTransmitting ? null : _onTapUp,
          onTapCancel: widget.isTransmitting ? null : _onTapCancel,
          onTap: widget.isTransmitting ? null : widget.onPressed,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ElevatedButton(
              onPressed: widget.isTransmitting ? null : widget.onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: widget.isTransmitting
                    ? Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.5)
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkullIcon(size: 48.0),
                  const SizedBox(height: 8),
                  const Text(
                    'Kill TVs',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
