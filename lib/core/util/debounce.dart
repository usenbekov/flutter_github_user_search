import 'dart:async';

class Debounce {
  static final _timers = <String, Timer>{};
  static final _completers = <String, Completer<bool>>{};
  static bool isCompleted(String id) => _completers[id]?.isCompleted ?? true;

  static cancel(String id) {
    if (!isCompleted(id)) {
      _completers[id]?.complete(false);
    }
    _timers[id]?.cancel();
    _timers.remove(id);
    _completers.remove(id);
  }

  static Future<bool> canContinue(String id, {int ms = 900}) {
    cancel(id);
    _completers[id] = Completer<bool>();
    final timer = Timer(Duration(milliseconds: ms), () {
      if (!isCompleted(id)) _completers[id]?.complete(true);
      cancel(id);
    });
    _timers[id] = timer;
    return _completers[id]!.future;
  }
}
