import 'package:flutter/material.dart';
import 'app.dart';
import 'core/Service/injection_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
