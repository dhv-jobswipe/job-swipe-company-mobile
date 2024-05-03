import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pbl5/constants.dart';
import 'package:pbl5/shared_customization/extensions/string_ext.dart';

class DisplayImage extends StatelessWidget {
  final String? urlPath;
  final String? filePath;
  final bool? gender;
  final VoidCallback? onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    this.urlPath,
    this.filePath,
    this.gender,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = orangePink;

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 4,
        top: 10,
      )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    ImageProvider? image;
    if (urlPath.isNotEmptyOrNull) {
      image = NetworkImage(urlPath!);
    } else if (filePath.isNotEmptyOrNull) {
      image = FileImage(File(filePath!));
    } else {
      image = gender ?? true
          ? AssetImage('assets/images/male_ava.jpg')
          : AssetImage('assets/images/female_ava.jpg');
    }

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
