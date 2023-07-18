import 'package:martes_emp_qr/src/models/products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE productos RENAME TO temp_productos');

      await db.execute('''
        CREATE TABLE productos(
          id INTEGER PRIMARY KEY,
          title TEXT,
          priceToSell INTEGER
        )
      ''');

      await db.execute('''
        INSERT INTO productos (id, title, priceToSell)
        SELECT id, title, priceToBuy FROM temp_productos
      ''');

      await db.execute('DROP TABLE temp_productos');
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'productos.db');
    return await openDatabase(
      path,
      version: 1,
      onUpgrade: _onUpgrade,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE productos(
        id INTEGER PRIMARY KEY,
        title TEXT,
        priceToSell INTEGER
      )
    ''');
  }

  Future<void> insertProducto(Product producto) async {
    Database? db = await database;

    await db?.insert(
      'productos',
      producto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProductos() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('productos');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // esta funcion es para borrar los datos de latabla
  Future<void> resetTable() async {
    Database? db = await database;
    await db?.delete('productos');
  }

  //! esta funcion es para borrar la tabla entera
  Future<void> clearTable() async {
    Database? db = await database;
    await db!.execute('DROP TABLE IF EXISTS productos');
    await _onCreate(
        db, 1); // Llama al método _onCreate para crear la tabla nuevamente
  }
}
