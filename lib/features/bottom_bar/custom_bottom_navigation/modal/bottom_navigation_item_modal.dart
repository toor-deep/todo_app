import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../shared/app_icons.dart';

class ItemData extends Equatable {
  final int id;
  final Widget view;
  final bool isDivider;
  final IconData? icon;
  final String title;
  final AppIcons selectedAppIcon;
  const ItemData({
    required this.id,
    required this.view,
    this.icon,
    this.isDivider = false,
    required this.title,
    this.selectedAppIcon= AppIcons.logo});

  @override
  List<Object?> get props => [id];
}