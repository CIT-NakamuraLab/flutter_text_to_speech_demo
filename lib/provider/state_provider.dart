import 'package:connect/models/opinion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<List<Map<String, dynamic>>> dataProvider = StateProvider(
  (ref) => [],
);

final StateProvider<bool> initloadProvider = StateProvider(
  (ref) => true,
);
