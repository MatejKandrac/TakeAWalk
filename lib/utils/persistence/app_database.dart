import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/event_dao.dart';
import 'dao/profile_dao.dart';
import 'entities/event.dart';
import 'entities/profile.dart';

part 'app_database.g.dart';

@Database(version: 2, entities: [Profile, Event])
abstract class AppDatabase extends FloorDatabase {
  ProfileDao get profileDao;
  EventDao get eventDao;
}
