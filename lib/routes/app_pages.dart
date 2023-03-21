import 'package:appalimentacion/ui/aom_last_step_page/view/aom_last_step_page.dart';
import 'package:appalimentacion/ui/login/login.dart';

import '../ui/aom_detalle_categoria_page/aom_detalle_categoria_page.dart';
import '../ui/aom_detalle_page/aom_detalle.dart';
import '../ui/lista_proyectos_aom_page/home.dart';
import 'app_routes.dart';

class AppPages {
  // static const INITIAL = Routes.HOME;

  static final routes = {
    AppRoutes.login: (context) => LoginPage.init(),
    AppRoutes.listaProyectosAOM: (context) => const ListaProyectosAomPage(),
    AppRoutes.aomDetalle: (context) => const AomDetallePage(),
    AppRoutes.aomDetalleCategoria: (context) => const AomDetalleCategoriaPage(),
    AppRoutes.aomLastStep: (context) => const LastStepAOMPage(),
  };
}
