import 'package:bmi_calculator/core/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../core/consts/styles.dart';

class HeightField extends StatefulWidget {
  final int height;
  final ValueChanged<int>? onChanged;

  const HeightField({
    super.key,
    required this.height,
    this.onChanged,
  });
  @override
  State<HeightField> createState() => _HeightFieldState();
}
class _HeightFieldState extends State<HeightField> {
  static const int _min = 100;
  static const int _max = 220;

  late FixedExtentScrollController _ctrl;
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.height.clamp(_min, _max);
    _ctrl = FixedExtentScrollController(initialItem: _selected - _min);
  }

  @override
  void didUpdateWidget(covariant HeightField old) {
    super.didUpdateWidget(old);
    // Keep wheel in sync if parent updates height externally.
    if (old.height != widget.height) {
      _selected = widget.height.clamp(_min, _max);
      _ctrl.jumpToItem(_selected - _min);
    }
  }
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Text('HEIGHT', style: TextStyle(
                fontSize: 18, fontFamily: bold,
                color: blueDarker
              )),
              const SizedBox(height: 8),
              Text(
                '$_selected cm',
                style: TextStyle(
                  fontFamily: regular, color: darkFontGrey, fontSize: 29
                ),
              ),
              const SizedBox(height: 12),
              /* ── Vertical wheel ── */
              SizedBox(
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListWheelScrollView.useDelegate(
                      controller: _ctrl,
                      physics: const FixedExtentScrollPhysics(),
                      itemExtent: 50,
                      perspective: 0.006,
                      overAndUnderCenterOpacity: 0.5,
                      onSelectedItemChanged: (i) {
                        setState(() => _selected = _min + i);
                        widget.onChanged?.call(_selected);
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _max - _min + 1,
                        builder: (_, i) {
                          final value = _min + i;
                          final selected = value == _selected;
                          return Center(
                            child: Text(
                              value.toString(),
                              style: selected
                                  ? TextStyle(
                                fontSize: 40,
                                fontFamily: medium,
                                color: blueDarker,
                              )
                                  : TextStyle(
                                fontSize: 24,
                                color: darkFontGrey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //  top & bottom fades (subtle)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [blueLighter, lightGreyOpaque],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [blueLighter,lightGreyOpaque],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
