/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Estimation extends _i1.TableRow {
  Estimation({
    int? id,
    required this.name,
    required this.topic,
    required this.storypoint,
  }) : super(id);

  factory Estimation.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Estimation(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      topic:
          serializationManager.deserialize<String>(jsonSerialization['topic']),
      storypoint: serializationManager
          .deserialize<String>(jsonSerialization['storypoint']),
    );
  }

  static final t = EstimationTable();

  String name;

  String topic;

  String storypoint;

  @override
  String get tableName => 'estimation';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'storypoint': storypoint,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'storypoint': storypoint,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'name': name,
      'topic': topic,
      'storypoint': storypoint,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'name':
        name = value;
        return;
      case 'topic':
        topic = value;
        return;
      case 'storypoint':
        storypoint = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Estimation>> find(
    _i1.Session session, {
    EstimationExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Estimation>(
      where: where != null ? where(Estimation.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Estimation?> findSingleRow(
    _i1.Session session, {
    EstimationExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Estimation>(
      where: where != null ? where(Estimation.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Estimation?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Estimation>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required EstimationExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Estimation>(
      where: where(Estimation.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Estimation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Estimation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Estimation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    EstimationExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Estimation>(
      where: where != null ? where(Estimation.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef EstimationExpressionBuilder = _i1.Expression Function(EstimationTable);

class EstimationTable extends _i1.Table {
  EstimationTable() : super(tableName: 'estimation');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final name = _i1.ColumnString('name');

  final topic = _i1.ColumnString('topic');

  final storypoint = _i1.ColumnString('storypoint');

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        topic,
        storypoint,
      ];
}

@Deprecated('Use EstimationTable.t instead.')
EstimationTable tEstimation = EstimationTable();
