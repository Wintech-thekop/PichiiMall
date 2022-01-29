class SQLiteHelper {
  final String nameDatabase = 'pichiimall.db';
  final int version = 1;
  final String tableDatabase = 'tableOrder';
  final String columnId = 'id';
  final String columnIdSeller = 'idSeller';
  final String columnIdProduct = 'idProduct';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnAmount = 'amount';
  final String columnSum = 'sum';

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {}
}
