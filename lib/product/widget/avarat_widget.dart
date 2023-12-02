import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AvatarWidget extends StatelessWidget {
  final String avatar;
  const AvatarWidget({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return const FaIcon(IconDataSolid(0xf21b));
  }
}
