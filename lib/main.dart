import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teldax/core/local_db/cache_helper.dart';
import 'package:teldax/firebase_options.dart';
import 'package:teldax/teldax.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Teldax());

}
