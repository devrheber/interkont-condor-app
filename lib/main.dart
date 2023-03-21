import 'dart:io';
import 'package:appalimentacion/blocs/network/network_bloc.dart';
import 'package:appalimentacion/data/local/aom_projects_api_impl.dart';
import 'package:appalimentacion/data/local/user_preferences.dart';
import 'package:appalimentacion/data/remote/aom_projects_impl.dart';
import 'package:appalimentacion/data/remote/login_remote.dart';
import 'package:appalimentacion/data/remote/projects_impl.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/local_storage_projects_cache_api.dart';
import 'package:appalimentacion/domain/repository/login_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_api.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/globales/ssl_solution.dart';
import 'package:appalimentacion/helpers/remote_config_service.dart';
import 'package:appalimentacion/translation/localizations_delegates.dart';
import 'package:appalimentacion/translation/supported_locales.dart';
import 'package:appalimentacion/ui/authentication/authentication_provider.dart';
import 'package:appalimentacion/ui/lista_proyectos_page/home.dart';
import 'package:appalimentacion/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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

import 'theme/color_theme.dart';
import 'translation/localizations_delegates.dart';
import 'translation/supported_locales.dart';
import 'ui/authentication/authentication_provider.dart';
import 'ui/lista_proyectos_page/projects_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final UserPreferences prefs = UserPreferences();

  final instance = await SharedPreferences.getInstance();

  final RemoteConfigService remoteConfig = RemoteConfigService();

  remoteConfig.init();

  final projectsRepository = ProjectsImpl();

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

  final aomProjectsImpl = AomProjectsImpl();

  await SentryFlutter.init(
    (options) {
      options.dsn = remoteConfig.getString('sentry_dsn');
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(AppState(
      prefs: prefs,
      projectsRepository: projectsRepository,
      projectsCacheRepository: projectsCacheRepository,
      sharedPreferences: instance,
      filesPersistentCacheApi: filesPersistentCacheApi,
      aomProjectsRepository: aomProjectsImpl,
    )),
  );
}

class AppState extends StatelessWidget {
  const AppState({
    Key? key,
    required this.prefs,
    required this.projectsRepository,
    required this.projectsCacheRepository,
    required this.filesPersistentCacheApi,
    required this.sharedPreferences,
    required this.aomProjectsRepository,
  }) : super(key: key);

  final UserPreferences prefs;
  final ProjectsRepository projectsRepository;
  final ProjectsCacheRepository projectsCacheRepository;
  final FilesPersistentCacheApi filesPersistentCacheApi;
  final SharedPreferences sharedPreferences;
  final AomProjectsRepository aomProjectsRepository;

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
          create: (_) => projectsRepository,
        ),
        Provider<AomProjectsRepository>(
          create: (_) => aomProjectsRepository,
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
            projectRepository: projectsRepository,
            filesPersistentCacheApi: filesPersistentCacheApi,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => NetworkBloc()..add(NetworkObserve()),
        child: MaterialApp(
          home: const App(),
          localizationsDelegates: LocalizationDelegates.delegates,
          supportedLocales: SupportedLocales.locale,
          theme: ThemeData(
            fontFamily: 'WorkSans',
            textTheme: AppTheme.textTheme,
          ),
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      verifySession();
    });
  }

  Future<void> verifySession() async {
    final authenticationProvider = context.read<AuthenticationProvider>();

    Navigator.of(context).pushAndRemoveUntil(
      authenticationProvider.user != null
          ? ListaProyectosPage.route()
          : LoginPage.route(),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorTheme.backgroundGradient,
        ),
        child: const Center(
          child: Hero(tag: 'loguito', child: LogoImg()),
        ),
      ),
    );
  }
}
