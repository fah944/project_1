import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/styles/themes/themes.dart';

import 'cubit/bloc_ob_server.dart';
import 'cubit/cubit.dart';
import 'layout/med_manage_layout.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MedManageApp());
}

class MedManageApp extends StatelessWidget {
  const MedManageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => MedManageCubit(),
          ),
        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: lightTheme,//light

          darkTheme:darkTheme,//dark

          //themeMode: MedManageCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light, //change between dark & light

          home: MedManageLayout(),
        ));

  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
