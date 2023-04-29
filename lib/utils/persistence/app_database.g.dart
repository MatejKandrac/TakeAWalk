// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProfileDao? _profileDaoInstance;

  EventDao? _eventDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Profile` (`id` INTEGER NOT NULL, `username` TEXT NOT NULL, `email` TEXT NOT NULL, `bio` TEXT, `profilePicture` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `owner` TEXT NOT NULL, `start` TEXT NOT NULL, `end` TEXT NOT NULL, `people` INTEGER NOT NULL, `places` INTEGER NOT NULL, `eventId` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProfileDao get profileDao {
    return _profileDaoInstance ??= _$ProfileDao(database, changeListener);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }
}

class _$ProfileDao extends ProfileDao {
  _$ProfileDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _profileInsertionAdapter = InsertionAdapter(
            database,
            'Profile',
            (Profile item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'bio': item.bio,
                  'profilePicture': item.profilePicture
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Profile> _profileInsertionAdapter;

  @override
  Future<Profile?> findProfileById(int id) async {
    return _queryAdapter.query('SELECT * FROM Profile WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Profile(
            id: row['id'] as int,
            username: row['username'] as String,
            email: row['email'] as String,
            bio: row['bio'] as String?,
            profilePicture: row['profilePicture'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> updateProfile(
    int id,
    String username,
    String email,
    String bio,
    String profilePicture,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE PROFILE SET id = ?1, username = ?2, email = ?3, bio = ?4, profilePicture = ?5 WHERE id = ?1',
        arguments: [id, username, email, bio, profilePicture]);
  }

  @override
  Future<void> insertProfile(Profile profile) async {
    await _profileInsertionAdapter.insert(profile, OnConflictStrategy.abort);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'owner': item.owner,
                  'start': item.start,
                  'end': item.end,
                  'people': item.people,
                  'places': item.places,
                  'eventId': item.eventId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  @override
  Future<List<Event>> getAllUserEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event;',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int,
            name: row['name'] as String,
            owner: row['owner'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            people: row['people'] as int,
            places: row['places'] as int,
            eventId: row['eventId'] as int));
  }

  @override
  Future<void> updateEvent(
    int id,
    String name,
    String owner,
    String start,
    String end,
    int people,
    int places,
    int eventId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE Event SET id = ?1, name = ?2, owner = ?3, start = ?4, end = ?5, people = ?6, places = ?7, eventId = ?8 WHERE eventId = ?8 ;',
        arguments: [id, name, owner, start, end, people, places, eventId]);
  }

  @override
  Future<Event?> isPresent(int eventId) async {
    return _queryAdapter.query('SELECT * FROM Event WHERE eventId = ?1 ;',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int,
            name: row['name'] as String,
            owner: row['owner'] as String,
            start: row['start'] as String,
            end: row['end'] as String,
            people: row['people'] as int,
            places: row['places'] as int,
            eventId: row['eventId'] as int),
        arguments: [eventId]);
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Event WHERE eventId = ?1 ;',
        arguments: [eventId]);
  }

  @override
  Future<void> insertEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }
}
