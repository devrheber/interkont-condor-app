class Project {
  Project({
    required this.codigoproyecto,
    required this.nombreproyecto,
    required this.valorproyecto,
    required this.valorejecutado,
    required this.porcentajeProyectado,
    required this.semaforoproyecto,
    required this.codigocategoria,
    required this.imagencategoria,
    required this.colorcategoria,
    required this.nombrecategoria,
    required this.objeto,
    this.contratista,
    required this.pendienteAprobacion,
    this.distaciaproyecto,
    required this.estadoobra,
  });

  int codigoproyecto;
  String nombreproyecto;
  double valorproyecto;
  double valorejecutado;
  double porcentajeProyectado;
  String semaforoproyecto;
  int codigocategoria;
  String imagencategoria;
  String colorcategoria;
  String nombrecategoria;
  String objeto;
  dynamic contratista;
  bool pendienteAprobacion;
  dynamic distaciaproyecto;
  int estadoobra;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        codigoproyecto: json["codigoproyecto"],
        nombreproyecto: json["nombreproyecto"],
        valorproyecto: json["valorproyecto"].toDouble(),
        valorejecutado: json["valorejecutado"].toDouble(),
        porcentajeProyectado: json["porcentajeProyectado"].toDouble(),
        semaforoproyecto: json["semaforoproyecto"],
        codigocategoria: json["codigocategoria"],
        imagencategoria: json["imagencategoria"],
        colorcategoria: json["colorcategoria"],
        nombrecategoria: json["nombrecategoria"],
        objeto: json["objeto"],
        contratista: json["contratista"],
        pendienteAprobacion: json["pendienteAprobacion"],
        distaciaproyecto: json["distaciaproyecto"],
        estadoobra: json["estadoobra"] == null ? 9 : json["estadoobra"],
      );

  Map<String, dynamic> toJson() => {
        "codigoproyecto": codigoproyecto,
        "nombreproyecto": nombreproyecto,
        "valorproyecto": valorproyecto,
        "valorejecutado": valorejecutado,
        "porcentajeProyectado": porcentajeProyectado,
        "semaforoproyecto": semaforoproyecto,
        "codigocategoria": codigocategoria,
        "imagencategoria": imagencategoria,
        "colorcategoria": colorcategoria,
        "nombrecategoria": nombrecategoria,
        "objeto": objeto,
        "contratista": contratista,
        "pendienteAprobacion": pendienteAprobacion,
        "distaciaproyecto": distaciaproyecto,
        "estadoobra": estadoobra,
      };

  String get nombreCategoriaUpperCase => nombrecategoria.toUpperCase();

  String get trafficLightColorValue {
    // TODO Define default value
    String trafficLightIcon = 'semaforo-3';
    if (semaforoproyecto == 'rojo') {
      trafficLightIcon = 'semaforo-3';
    } else if (semaforoproyecto == 'amarillo') {
      trafficLightIcon = 'semaforo-2';
    } else if (semaforoproyecto == 'verde') {
      trafficLightIcon = 'semaforo-1';
    }

    return trafficLightIcon;
  }

  String get projectValueRounded {
    double valorProyectoRedondeado = valorproyecto / 1000000;
    valorProyectoRedondeado =
        double.parse((valorProyectoRedondeado).toStringAsFixed(1));

    return '\$ $valorProyectoRedondeado M';
  }

  double get percentageByValue {
    double porcentaje = (100 * valorejecutado) / valorproyecto;

    return porcentaje;
  }

  int get titleColor {
    final colorTitulo = "0XFF" + colorcategoria.split('#')[1];
    return int.parse(colorTitulo);
  }

  double get asiVaPorcentajeDouble {
    final value = ((100 * valorejecutado) / valorproyecto);

    return value;
  }

  double get deberiaIr {
    return (porcentajeProyectado / 100) * valorproyecto;
  }

  String get dineroDeberiaIr =>
      '${((porcentajeProyectado / 100) * valorproyecto)}';

  String get getProjectCode => codigoproyecto.toString();

  String get getCurrentTrafficLightColor {
    if (semaforoproyecto == 'rojo') {
      return 'semaforo-3';
    }
    if (semaforoproyecto == 'amarillo') {
      return 'semaforo-2';
    }
    if (semaforoproyecto == 'verde') {
      return 'semaforo-1';
    }

    return 'semaforo-3';
  }

  String getNewTrafficLightColor({
    required double currentProgress,
    required double projectedValue,
    required double latePercentageLimit,
    required double yellowLatePercentageLimit,
  }) {
    double datoVerde = (100 - (currentProgress / projectedValue) * 100);

    if (datoVerde <= latePercentageLimit) {
      return 'semaforo-1';
    }
    if (datoVerde > latePercentageLimit &&
        datoVerde <= yellowLatePercentageLimit) {
      return 'semaforo-2';
    }
    if (datoVerde > yellowLatePercentageLimit) {
      return 'semaforo-3';
    }

    return 'semaforo-3';
  }
}
