part of '../starlight_thread.dart';

class StarlightThread<R, T> {
  ///Current [DateTime]
  final DateTime _dateTime = DateTime.now();

  ///call back
  final FutureOr<R> Function(T) _callback;

  ///unique
  final bool _distinct;

  ///private [StarlightThread] constructor
  StarlightThread._prepare({
    required FutureOr<R> Function(T) callback,
    bool distinct = false,
  })  : _callback = callback,
        _distinct = distinct {
    _init();
  }

  ///private [ReceivePort] with debug name
  late final ReceivePort _receivePort = ReceivePort(
    _debugName,
  );

  ///private [SendPort]
  late SendPort _sendPort;

  ///private [StreamController] for [return] data
  final StreamController<R> _controller = StreamController<R>.broadcast();

  ///data listener [Stream]
  Stream<R> get stream => _controller.stream.distinct(
        _distinct ? _equatable : null,
      );

  ///private data store [List]
  final List<R> _result = [];

  ///data getter [List]
  List<R> get result => _result;

  ///private constructor [Function]
  void _init() {
    _receivePort.listen(_threadListener);
    _sendPort = _receivePort.sendPort;
  }

  ///private thread listener [Function]
  void _threadListener(message) async {
    message as T;
    compute(_callback, message).then((isolateData) {
      _controller.sink.add(isolateData);
      _result.add(isolateData);
      ValueNotifier(_result);
    }).catchError((isolateError) {
      _controller.sink.addError(Exception(isolateError));
    });
  }

  ///to execute call back [Function]
  void execute(T data) => _sendPort.send(data);

  ///to dispose [StarlightThread]
  Future<void> dispose() async {
    _receivePort.close();
    await _controller.close();
    _result.clear();
  }

  ///[StarlightThread] constructor
  ///[FutureOr] call back is required
  ///[bool] distinct is optional
  factory StarlightThread.prepare({
    required FutureOr<R> Function(T) callback,
    bool distinct = false,
  }) =>
      StarlightThread._prepare(
        callback: callback,
        distinct: distinct,
      );

  ///[StarlightThread] static method
  ///[FutureOr] call back is required
  ///[T] data is required
  static FutureOr<R>? wait<R, T>({
    required FutureOr<R> Function(T) callback,
    required T data,
  }) =>
      compute(callback, data);

  ///to [String]
  @override
  String toString() => "StarlightThread Id $_debugName";

  ///no such method [String]
  @override
  noSuchMethod(Invocation invocation) {
    debugPrint("${invocation.memberName} was no exist");
    return "${invocation.memberName} was no exist";
  }
}
