import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/network/network_bloc.dart';
import '../widgets/home/fondoHome.dart';
import 'proyectos_aom.dart';

class ListaProyectosAomPage extends StatelessWidget {
  const ListaProyectosAomPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        debugPrint('rebuild');
        if (state is NetworkFailure || state is NetworkInitial) {
          return const AomNoInternetWidget();
        }

        return const FondoHome(
          body: const ProyectsoContenidoAOMState(),
          showMenuButton: true,
        );
      },
    );
  }
}
