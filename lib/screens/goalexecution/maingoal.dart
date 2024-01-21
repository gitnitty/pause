import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class MainGoal {
  String? id;
  String? uid;
  Color? selectColor;
  Color? backgroundColor;
  bool? finish;
  DateTime? deadline;
  String? memo;

  MainGoal({
    this.id,
    this.uid,
    this.selectColor,
    this.backgroundColor,
    this.finish,
    this.deadline,
    this.memo,
  });

  // Factory constructor to create MainGoal from a Map
  factory MainGoal.fromMap(Map<String, dynamic> map) {
    return MainGoal(
      id: map['id'] as String?,
      uid: map['uid'] as String?,
      selectColor: _hexToColor(map['selectColor'] as String?),
      backgroundColor: _hexToColor(map['backgroundColor'] as String?),
      finish: map['finish'] as bool?,
      deadline: (map['deadline'] as Timestamp?)?.toDate(),
      memo: map['memo'] as String?,
    );
  }

  // Convert MainGoal to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'selectColor': _colorToHex(selectColor),
      'backgroundColor': _colorToHex(backgroundColor),
      'finish': finish,
      'deadline': deadline,
      'memo': memo,
    };
  }

  // Helper method to convert hex color string to Color
  static Color? _hexToColor(String? hexColor) {
    return hexColor != null ? Color(int.parse(hexColor, radix: 16)) : null;
  }

  // Helper method to convert Color to hex color string
  static String? _colorToHex(Color? color) {
    return color != null
        ? '#${color.value.toRadixString(16).padLeft(8, '0')}'
        : null;
  }
}
