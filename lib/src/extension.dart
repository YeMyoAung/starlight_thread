part of starlight_thread;

extension _StarlightThreadExtension<R, T> on StarlightThread {
  String get _debugName =>
      "${_dateTime.year}${_dateTime.month}${_dateTime.day}${_dateTime.hour}${_dateTime.minute}${_dateTime.second}";

  bool _equatable(R prev, R current) => prev.hashCode == current.hashCode;

  R? get first => _result.isEmpty ? null : _result.first;

  R? get last => _result.isEmpty ? null : _result.last;
}
