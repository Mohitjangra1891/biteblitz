import 'package:flutter_riverpod/flutter_riverpod.dart';

final authTokenProvider = StateProvider<String?>((ref) => null);
final liveStatusProvider = StateProvider<bool>((ref) => false);
