import 'package:flutter/material.dart';
import 'package:pomodoro/data/tasks/actions.dart';
import 'package:pomodoro/data/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/tasks/state.dart';


class Timer {

  int duration;
  Color color;

  Timer({this.duration, this.color,});

}

Timer workTimer = Timer(
  duration: 10,
  color: Colors.red
);

Timer shortBreakTimer = Timer(
  duration: 5,
  color: Colors.blue
);

Timer longBreakTimer = Timer(
  duration: 15,
  color: Colors.green
);

var timerIteration = 1;

class CountdownMiddleware extends MiddlewareClass<AppState> {

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {

    _pomoCountdownFinish() {

      next(new StopTimerAction());

      timerIteration += 1;

      // change the value of start to true
      next(new PlayPauseAction());

      if (timerIteration % 2 == 0) {
        if (timerIteration % 8 == 0) {
          next(new UpdateTimeAction(longBreakTimer.duration));
          next(new DisplayLongBreakAction());
        }
        else {
          next(new UpdateTimeAction(shortBreakTimer.duration));
          next(new DisplayShortBreakAction());
        }
      }
      else {
        next(new UpdateTimeAction(workTimer.duration));
        next(new DisplayPomodoroAction());
      }
    }

    if(action is PlayPauseAction && store.state.tasksState.countdown) {
      next(new StartTimerAction(workTimer.duration, () => !store.state.tasksState.countdown ? (store.state.tasksState.countdownTime < 1 ? _pomoCountdownFinish() : next(new UpdateTimeAction(store.state.tasksState.countdownTime - 1))) : null));
      //print(store.state.tasksState.countdownTime);
    }

    if(action is DisplayNoneAction) {
      if(!store.state.tasksState.countdown) {
        next(new PlayPauseAction());
      }
      next(new StopTimerAction());
    }

    next(action);
  }
}