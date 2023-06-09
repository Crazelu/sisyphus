import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sissyphus/app.dart';
import 'package:sissyphus/utils/logger.dart';

void main() {
  LoggerConfig.disableLogs();
  runApp(const ProviderScope(child: SissyphusApp()));
}
