import 'actions.dart';

int reducer(int state, dynamic action) {
  if (action is IncrementOneAction) {
    return state + 1;
  } else if (action is IncrementZeroAction) {
    return state + 0;
  }
  return state;
}
