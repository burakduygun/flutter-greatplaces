import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    //olusturmak uzere oldugumuz veritabanını depolayabilcegimiz yoldur cunku bu veritabanı uygulamamizla birlikte gelmez, temel olarak uygulama klasorumuzde veya sabit diskimizde uygulamamız icin ayrılmis bir klasorde boyle bir veritabani olusturmammız gerekir
    final dbPath = await sql.getDatabasesPath();
    //veritabanini acmamizi saglar
    //sqflite veritabanini acmaya calistiginda ve doyayı bulamadıgında calistirilacak adlandırılmıs veya anonim bir fonksiyon
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRİMARY KEY, title TEXT,image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  //bir veritabanı islemi biraz daa uzun surebilir bu nedenle asenkrondur
  static Future<void> insert(String table, Map<String, Object> data) async {
    //conflictAlgorithm: sql.ConflictAlgorithm.replace, zaten bulunan bir ID icin veri eklemeye calisiyorsak mevcut kaydi yeni verilerle gecersiz kilacagimiz anlamina gelir
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    //veri almak icin query methodu kullanilir ve veryi almak istedigimiz tabloyu alir ve tablodaki tum degerleri dondurur
    return db.query(table);
  }
}
