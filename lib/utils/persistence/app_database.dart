import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/profile_dao.dart';
import 'entities/profile.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Profile])
abstract class AppDatabase extends FloorDatabase {
  ProfileDao get profileDao;
}