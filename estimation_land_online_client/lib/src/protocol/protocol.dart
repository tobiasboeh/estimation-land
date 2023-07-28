/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'estimation.dart' as _i2;
import 'package:estimation_land_online_client/src/protocol/estimation.dart'
    as _i3;
export 'estimation.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Estimation) {
      return _i2.Estimation.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Estimation?>()) {
      return (data != null ? _i2.Estimation.fromJson(data, this) : null) as T;
    }
    if (t == List<_i3.Estimation>) {
      return (data as List).map((e) => deserialize<_i3.Estimation>(e)).toList()
          as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i2.Estimation) {
      return 'Estimation';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Estimation') {
      return deserialize<_i2.Estimation>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
