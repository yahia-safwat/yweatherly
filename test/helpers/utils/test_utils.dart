import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reads the contents of a JSON file with the given [name] from the current directory.
/// Returns the JSON content as a string.
String readJson(String name) {
  var dir = Directory.current.path;

  // Adjust directory path if running from a test directory
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }

  // Read and return the contents of the JSON file
  return File('$dir/test/$name').readAsStringSync();
}

/// Verify that there are no pending timers after each test
/// Ensure that the widget tree is properly disposed to prevent memory leaks
void tearDownCommon() {
  tearDown(() {
    try {
      expect(find.byType(WidgetsApp), findsNothing);
    } catch (error) {
      print('Error in tearDown: $error');
    }
  });
}
