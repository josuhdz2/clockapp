import 'dart:async';

import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary show rotaryEvents;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reloj_aplicacion/cubit/counterCubit.dart';
class CounterPage extends StatelessWidget
{
  const CounterPage({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider
    (
      create: (_)=>CounterCubit(),
      child: CounterView(),
    );
  }
}
//clase stateFull
class CounterView extends StatefulWidget
{
  CounterView({super.key, @visibleForTesting Stream<RotaryEvent>? rotaryEvents}):rotaryEvents=rotaryEvents??wearable_rotary.rotaryEvents;
  final Stream<RotaryEvent> rotaryEvents;
  @override
  State<CounterView> createState() => _CounterViewState();
}
class _CounterViewState extends State<CounterView>
{
  late final StreamSubscription<RotaryEvent> rotarySubscription;
  @override
  void initState()
  {
    rotarySubscription=widget.rotaryEvents.listen(handleRotaryEvent);
    super.initState();
  }
  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }
  void handleRotaryEvent(RotaryEvent event)
  {
    final cubit=context.read<CounterCubit>();
    if(event.direction==RotaryDirection.clockwise)
    {
      cubit.increment();
    }
    else
    {
      cubit.decrement();
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      body:SizedBox.expand
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            ElevatedButton
            (
              onPressed: ()=>context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add)
            ),
            const SizedBox
            (
              height: 10
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                const CounterText(),
                ElevatedButton
                (
                  onPressed: ()=>context.read<CounterCubit>().deleteNumber(),
                  child: const Icon(Icons.update)
                )
              ],
            ),
            const SizedBox
            (
              height: 10
            ),
            ElevatedButton
            (
              onPressed: ()=>context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove)
            )
          ],
        ),
      )
    );
  }
}
//clase CounterText
class CounterText extends StatelessWidget
{
  const CounterText({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayMedium);
  }
}