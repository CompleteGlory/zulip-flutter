import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'licenses.dart';
import 'log.dart';
import 'model/binding.dart';
import 'notifications/receive.dart';
import 'widgets/app.dart';
import 'widgets/emoji.dart';
import 'widgets/share.dart';

// This library defines the Dart entrypoint function for the
// headless Flutter engine used in our iOS "NotificationService" app extension.
// Importing it here causes it to be included in the build.
// ignore: unused_import
import 'notifications/ios_service.dart';

void main() {
  mainInit();
  runApp(const ZulipApp());
}

/// Everything [main] does short of [runApp].
///
/// This is useful for setup in Patrol-based integration tests.
void mainInit() {
  assert(() {
    debugLogEnabled = true;
    // This branch exists to exercise the text-emoji fallback that an image
    // emoji uses when its image fails to load, so that the two cases can be
    // compared side by side.  Set to false for the ordinary case.
    debugSimulateEmojiImageFailure = true;
    return true;
  }());
  LicenseRegistry.addLicense(additionalLicenses);
  WidgetsFlutterBinding.ensureInitialized();
  LiveZulipBinding.ensureInitialized();
  NotificationService.instance.start();
  ShareService.start();
}
