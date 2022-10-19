import 'dart:io';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/data/remote/login_remote.dart';
import 'package:appalimentacion/data/remote/projects_impl.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/local_storage_projects_cache_api.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_api.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/globales/ssl_solution.dart';
import 'package:appalimentacion/translation/localizations_delegates.dart';
import 'package:appalimentacion/translation/supported_locales.dart';
import 'package:appalimentacion/ui/listaProyectos/home.dart';
import 'package:appalimentacion/ui/listaProyectos/projects_provider.dart';
import 'package:appalimentacion/ui/login/login.dart';
import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globales/colores.dart';
import 'globales/logo.dart';
import 'theme/color_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final UserPreferences prefs = UserPreferences();

  final instance = await SharedPreferences.getInstance();

  final projectsCacheApi = LocalStorageProjectsCacheApi(
    plugin: instance,
  );

  final projectsCacheRepository = ProjectsCacheRepository(
    projectsCacheApi: projectsCacheApi,
  );

  await prefs.initPrefs();

  runApp(AppState(
    prefs: prefs,
    projectsCacheRepository: projectsCacheRepository,
    sharedPreferences: instance,
  ));
}

class AppState extends StatelessWidget {
  const AppState({
    Key? key,
    required this.prefs,
    required this.projectsCacheRepository,
    required this.sharedPreferences,
  }) : super(key: key);

  final UserPreferences prefs;
  final ProjectsCacheRepository projectsCacheRepository;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProjectsCacheRepository>(
          create: (_) => projectsCacheRepository,
        ),
        Provider<FilesPersistentCacheRepository>(
          create: (_) => FilesPersistentCacheApi(
            plugin: sharedPreferences,
          ),
        ),
        Provider<LoginRepository>(
          create: (_) => LoginRemote(),
        ),
        Provider<UserPreferences>(
          create: (_) => prefs,
        ),
        Provider<ProjectsRepository>(
          create: (_) => ProjectsImpl(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(
            loginRepository: LoginRemote(),
            prefsRepository: prefs,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProjectsProvider(
            projectsCacheRepository: projectsCacheRepository,
            projectRepository: ProjectsImpl(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: (_,__) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const App(),
            localizationsDelegates: LocalizationDelegates.delegates,
            supportedLocales: SupportedLocales.locale,
            theme: ThemeData(
              fontFamily: 'WorkSans',
              textTheme: AppTheme.textTheme,
            ),
          );
        },
      ),
    );
  }
}

class App extends StatefulWidget {
  const App();
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () async {
      await verifySession();
    });
  }

  Future<void> verifySession() async {
    Widget rootPage;
    final authenticationProvider = context.read<AuthenticationProvider>();

    if (authenticationProvider.user != null) {
      rootPage = ListaProyectos();
    } else {
      rootPage = LoginPage.init();
    }

    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => rootPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: ColorTheme.backgroundGradient,
          ),
          child: Center(
            child: LogoImg(),
          )),
    );
  }
}
