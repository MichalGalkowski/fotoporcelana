import 'package:fotoporcelana/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsDB {
  static final ProductsDB instance = ProductsDB._init();
  static Database? _database;

  ProductsDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableProducts (
${ProductFields.id} $idType,
${ProductFields.title} $textType,
${ProductFields.data} $textType,
${ProductFields.attachments} $textType,
${ProductFields.amount} $integerType,
${ProductFields.time} $textType
)
 ''');
  }

  Future<Product> create(Product product) async {
    final db = await instance.database;

    await db.insert(tableProducts, product.toJson());
    return product.copy();
  }

  Future<Product> readProduct(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableProducts,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('ID $id nie znaleziono');
    }
  }

  Future<List<Product>> readAllProducts() async {
    final db = await instance.database;

    const orderBy = '${ProductFields.time} ASC';
    final result = await db.query(tableProducts, orderBy: orderBy);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;

    return db.update(
      tableProducts,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;

    return await db.delete(
      tableProducts,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;

    return await db.delete(tableProducts);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
