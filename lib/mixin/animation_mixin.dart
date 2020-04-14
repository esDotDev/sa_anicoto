part of sa_anicoto;

mixin AnimationMixin<T extends StatefulWidget> on State<T> implements TickerProvider {

  AnimationController _mainControllerInstance;

  final _controllerInstances = List<AnimationController>();

  // TODO doc
  AnimationController get controller {
    if (_mainControllerInstance == null) {
      _mainControllerInstance = _newAnimationController();
    }
    return _mainControllerInstance;
  }

  // TODO doc
  AnimationController createController() {
      final instance = _newAnimationController();
      _controllerInstances.add(instance);
      return instance;
  }

  AnimationController _newAnimationController() {
    final controller = AnimationController(vsync: this, duration: 1.seconds);
    controller.addListener(() => setState(() {}));
    return controller;
  }

  // below code from TickerProviderStateMixin (dispose method is modified) ----------------------------------------

  Set<Ticker> _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_WidgetTicker>{};
    final _WidgetTicker result = _WidgetTicker(onTick, this, debugLabel: 'created by $this');
    _tickers.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers != null);
    assert(_tickers.contains(ticker));
    _tickers.remove(ticker);
  }

  @override
  void dispose() {
    // Added disposing for created entities
    if (_mainControllerInstance != null) {
      _mainControllerInstance.dispose();
    }
    _controllerInstances.forEach((instance) => instance.dispose());
    // Original dispose code
    assert(() {
      if (_tickers != null) {
        for (Ticker ticker in _tickers) {
          if (ticker.isActive) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('$this was disposed with an active Ticker.'),
              ErrorDescription(
                  '$runtimeType created a Ticker via its TickerProviderStateMixin, but at the time '
                      'dispose() was called on the mixin, that Ticker was still active. All Tickers must '
                      'be disposed before calling super.dispose().'
              ),
              ErrorHint(
                  'Tickers used by AnimationControllers '
                      'should be disposed by calling dispose() on the AnimationController itself. '
                      'Otherwise, the ticker will leak.'
              ),
              ticker.describeForError('The offending ticker was'),
            ]);
          }
        }
      }
      return true;
    }());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final bool muted = !TickerMode.of(context);
    if (_tickers != null) {
      for (Ticker ticker in _tickers) {
        ticker.muted = muted;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Set<Ticker>>(
      'tickers',
      _tickers,
      description: _tickers != null ?
      'tracking ${_tickers.length} ticker${_tickers.length == 1 ? "" : "s"}' :
      null,
      defaultValue: null,
    ));
  }
}

// This class should really be called _DisposingTicker or some such, but this
// class name leaks into stack traces and error messages and that name would be
// confusing. Instead we use the less precise but more anodyne "_WidgetTicker",
// which attracts less attention.
class _WidgetTicker extends Ticker {
  _WidgetTicker(TickerCallback onTick, this._creator, { String debugLabel }) : super(onTick, debugLabel: debugLabel);

  final AnimationMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
