import 'dart:io';

import 'package:appalimentacion/blocs/network/network_bloc.dart';
import 'package:appalimentacion/data/local/aom_projects_api_impl.dart';
import 'package:appalimentacion/data/remote/aom_projects_impl.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/local/user_preferences.dart';
import 'data/remote/login_remote.dart';
import 'data/remote/projects_impl.dart';
import 'domain/repository/cache_repository.dart';
import 'domain/repository/files_persistent_cache_api.dart';
import 'domain/repository/files_persistent_cache_repository.dart';
import 'domain/repository/local_storage_projects_cache_api.dart';
import 'domain/repository/login_repository.dart';
import 'domain/repository/projects_repository.dart';
import 'globales/colores.dart';
import 'globales/logo.dart';
import 'globales/ssl_solution.dart';
import 'routes/app_pages.dart';
import 'theme/color_theme.dart';
import 'translation/localizations_delegates.dart';
import 'translation/supported_locales.dart';
import 'ui/authentication/authentication_provider.dart';
import 'ui/lista_proyectos_page/projects_provider.dart';

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

  final filesPersistentCacheApi = FilesPersistentCacheApi(
    plugin: instance,
  );

  await prefs.initPrefs();

  runApp(
    AppState(
      prefs: prefs,
      projectsCacheRepository: projectsCacheRepository,
      sharedPreferences: instance,
      filesPersistentCacheApi: filesPersistentCacheApi,
    ),
  );
}

class AppState extends StatelessWidget {
  const AppState({
    Key? key,
    required this.prefs,
    required this.projectsCacheRepository,
    required this.filesPersistentCacheApi,
    required this.sharedPreferences,
  }) : super(key: key);

  final UserPreferences prefs;
  final ProjectsCacheRepository projectsCacheRepository;
  final FilesPersistentCacheApi filesPersistentCacheApi;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProjectsCacheRepository>(
          create: (_) => projectsCacheRepository,
        ),
        Provider<FilesPersistentCacheRepository>(
            create: (_) => filesPersistentCacheApi),
        Provider<LoginRepository>(
          create: (_) => LoginRemote(),
        ),
        Provider<UserPreferences>(
          create: (_) => prefs,
        ),
        Provider<ProjectsRepository>(
          create: (_) => ProjectsImpl(),
        ),
        Provider<AomProjectsRepository>(
          create: (_) => AomProjectsImpl(),
        ),
        Provider<AomProjectsApi>(
          create: (_) => AomProjectsApiImpl(),
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
            filesPersistentCacheApi: filesPersistentCacheApi,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => NetworkBloc()..add(NetworkObserve()),
        child: ScreenUtilInit(
          designSize: Size(414, 896),
          builder: (_, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const App(),
              localizationsDelegates: LocalizationDelegates.delegates,
              supportedLocales: SupportedLocales.locale,
              theme: ThemeData(
                fontFamily: 'WorkSans',
                textTheme: AppTheme.textTheme,
              ),
              routes: AppPages.routes,
            );
          },
        ),
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
    final authenticationProvider = context.read<AuthenticationProvider>();

    // rootPage = ListaProyectos();
    Navigator.pushNamedAndRemoveUntil(
      context,
      authenticationProvider.user != null
          ? AppRoutes.listaProyectos
          : AppRoutes.login,
      (route) => false,
    );
    return;
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
        ),
      ),
    );
  }
}
