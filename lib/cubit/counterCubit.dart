import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CounterCubit extends Cubit<int>
{
  CounterCubit() : super(0);
  //void increment() => emit(state + 1);
  void increment()
  {
    if(state!=10)
    {
      emit(state+1);
    }
    else
    {
      Fluttertoast.showToast
      (
        msg: "Se alcanzo el limite maximo"
      );
    }
  }
  //void decrement() => emit(state - 1);
  void decrement()
  {
    if(state!=-10)
    {
      emit(state-1);
    }
    else
    {
      Fluttertoast.showToast
      (
        msg: "Se alcanzo el limite minimo",
        fontSize: 10
      );
    }
  }
  void deleteNumber()=>emit(0);
}