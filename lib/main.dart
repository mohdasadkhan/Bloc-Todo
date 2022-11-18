import 'package:flutter/material.dart';
import 'package:xtodo/blocs/bloc_exports.dart';
import 'package:xtodo/constants/const.dart';
import 'package:xtodo/screens/tabs_screen.dart';
import 'package:xtodo/screens/pending_screen.dart';
import 'package:xtodo/services/app_router.dart';
import 'package:xtodo/services/app_theme.dart';

void main() async {
  //Hydtrated storage call native call before that call we have to initialize widgets binding before we start building our app otherwise hydtrated bloc will not able to make native call
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
