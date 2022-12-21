import 'package:fotoporcelana/models/attachments.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AttachmentsDB {
  static final AttachmentsDB instance = AttachmentsDB._init();
  static Database? _database;

  AttachmentsDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('attachments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableAttachments (
${AttachmentsFields.id} $idType,
${AttachmentsFields.path} $textType,
${AttachmentsFields.product} $textType,
${AttachmentsFields.time} $textType
)
 ''');
  }

  Future<Attachments> create(Attachments attachments) async {
    final db = await instance.database;

    final id = await db.insert(tableAttachments, attachments.toJson());
    return attachments.copy(id: id);
  }

  Future<Attachments> readAttachment(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAttachments,
      columns: AttachmentsFields.values,
      where: '${AttachmentsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Attachments.fromJson(maps.first);
    } else {
      throw Exception('ID $id nie znaleziono');
    }
  }

  Future<List<Attachments>> readAllAttachments() async {
    final db = await instance.database;

    const orderBy = '${AttachmentsFields.time} ASC';
    final result = await db.query(tableAttachments, orderBy: orderBy);
    return result.map((json) => Attachments.fromJson(json)).toList();
  }

  Future<List<Attachments>> readAttachmentsById(String id) async {
    final db = await instance.database;

    const orderBy = '${AttachmentsFields.time} ASC';
    final result = await db.query(tableAttachments,
        where: '${AttachmentsFields.product} = ?',
        whereArgs: [id],
        orderBy: orderBy);
    return result.map((json) => Attachments.fromJson(json)).toList();
  }

  Future<int> update(Attachments attachments) async {
    final db = await instance.database;

    return db.update(
      tableAttachments,
      attachments.toJson(),
      where: '${AttachmentsFields.id} = ?',
      whereArgs: [attachments.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return await db.delete(
      tableAttachments,
      where: '${AttachmentsFields.product} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.delete(tableAttachments);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
