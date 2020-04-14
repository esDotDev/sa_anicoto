part of sa_anicoto;

extension AnimationControllerExtension on AnimationController {
  TickerFuture play({Duration duration}) {
    this.duration = duration ?? this.duration;
    return forward();
  }

  TickerFuture playReverse({Duration duration}) {
    this.duration = duration ?? this.duration;
    return reverse();
  }

  TickerFuture loop({Duration duration}) {
    this.duration = duration ?? this.duration;
    return repeat();
  }

  TickerFuture mirror({Duration duration}) {
    this.duration = duration ?? this.duration;
    return repeat(reverse: true);
  }
}
