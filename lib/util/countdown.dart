import 'package:pomodoro/data/tasks/actions.dart';
import 'package:pomodoro/data/state.dart';
import 'package:redux/redux.dart';

const int _DEFAULT_TIME = 10;
const int _DEFAULT_BREAK_TIME = 5;
const int _LONG_BREAK_TIME = 15;

var timerIteration = 1;

class CountdownMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {

    _pomoCountdownFinish() {

      next(new StopTimerAction());
      next(new DisplayBreakAction());

      timerIteration += 1;

      if (timerIteration % 2 == 0) {
        if (timerIteration % 8 == 0) {
          next(new UpdateTimeAction(_LONG_BREAK_TIME));
        }
        else {
          next(new UpdateTimeAction(_DEFAULT_BREAK_TIME));
        }
      }
      else {
        next(new UpdateTimeAction(_DEFAULT_TIME));
      }
    }

    if(action is PlayPauseAction && store.state.tasksState.countdown) {
      next(new StartTimerAction(_DEFAULT_TIME, () => !store.state.tasksState.countdown ? (store.state.tasksState.countdownTime < 1 ? _pomoCountdownFinish() : next(new UpdateTimeAction(store.state.tasksState.countdownTime - 1))) : null));
      //print(store.state.tasksState.countdownTime);
    }

    if(action is PlayPauseAction) {
      //print("${store.state.tasksState.countdown ? "playing - show pause button" : "paused - show play button"}");
    }

    if(action is DisplayNoneAction) {
      if(!store.state.tasksState.countdown) {
        next(new PlayPauseAction());
      }
      next(new StopTimerAction());
      //print("stop");
     // next(new UpdateTimeAction(_DEFAULT_TIME));
    }

    next(action);
  }
}