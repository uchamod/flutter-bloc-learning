import 'package:flutter_bloc/flutter_bloc.dart';

//the central point to track and analysis all the bloc in the system
//this class which is bloc observer reduce the need of creting tracking functions for all blocs seperatly
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    // TODO: implement onCreate
    super.onCreate(bloc);
    print("$bloc was cretaed");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print("the $bloc is changed to $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print("the $bloc is transit to $transition");
  }
}
