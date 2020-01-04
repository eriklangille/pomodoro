import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/reducer.dart';
import 'package:pomodoro/data/state.dart';
import 'package:redux/redux.dart';

const int _DEFAULT_TIME = 10;
const int _DEFAULT_BREAK_TIME = 5;

class CountdownMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {

    _pomoCountdownFinish() {
      next(new StopTimerAction());
      next(new DisplayBreakAction());
      next(new UpdateTimeAction(_DEFAULT_BREAK_TIME));
    }

    if(action is PlayPauseAction && store.state.countdown) {
      next(new StartTimerAction(_DEFAULT_TIME, () => !store.state.countdown ? (store.state.countdownTime < 1 ? _pomoCountdownFinish() : next(new UpdateTimeAction(store.state.countdownTime - 1))) : null));
      print(store.state.countdownTime);
    }

    if(action is PlayPauseAction) {
      print("${store.state.countdown ? "playing - show pause button" : "paused - show play button"}");
    }

    if(action is DisplayNoneAction) {
      if(!store.state.countdown) {
        next(new PlayPauseAction());
      }
      next(new StopTimerAction());
      print("stop");
      next(new UpdateTimeAction(_DEFAULT_TIME));
    }

    next(action);
  }
}