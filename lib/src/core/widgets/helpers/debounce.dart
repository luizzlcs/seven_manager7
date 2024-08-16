import 'dart:async';
import 'dart:ui';

class Debounce {
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 10), action); 
  }
}