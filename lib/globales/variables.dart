library my_prj.variables;

// String urlGlobal = 'https://sienteapp.gestiondelriesgo.gov.co';
String urlGlobal = 'http://backendavanzame.minenergia.gov.co/avanzame-ws';
// String urlGlobal = 'http://13.59.62.87:7074';
// String urlGlobal = 'https://sienteapp.gestiondelriesgo.gov.co';

// String urlGlobal = 'https://sienteapp.gestiondelriesgo.gov.co';
// String urlGlobal = 'https://appcondor.car.gov.co';
// String urlGlobalApiCondor = urlGlobal + '/siente3-ws';
String urlGlobalApiCondor = urlGlobal + '/avanzame-ws';
// String urlGlobalApiCondor = urlGlobal + '/siente3-ws';
int posicionListaProyectosSeleccionado = 0;
String txtBtnDesplegableAvanceCualitativo = '';
int idAspectoEvaluar;
int keyboardVisibilitySubscriberId;
int keyboardVisibilitySubscriberId2;
int keyboardVisibilitySubscriberId3; // DE TODA LA CARPETA DE REPORTAR AVANCE
bool conexionInternet = true;
bool bool_estSegundoBtn_reportarAvance = false;
String numeroVersion = "1.0.0";
List contenidoWebService = [
  {
    'usuario': {'idUsu': '0', 'nombreUsu': 'demo', 'tokenUsu': 'token'},
    'proyectos': [
      {
        "codigoproyecto": '',
        "nombreproyecto": '',
        "valorproyecto": '',
        "valorejecutado": '',
        "porcentajeProyectado": '',
        "semaforoproyecto": '',
        "codigocategoria": '',
        "imagencategoria": '',
        "colorcategoria": '',
        "nombrecategoria": '',
        "objeto": '',
        "contratista": '',
        "pendienteAprobacion": '',
        "paso": '', //CACHE
        "ultimaFechaSincro": '', //CACHE
        "porPublicar": '', //CACHE
        "datos": {
          "limitePorcentajeAtraso": '',
          "periodoIdSeleccionado": '', //CACHE
          'porcentajeValorProyectadoSeleccionado': '', //CACHE
          'porcentajeValorEjecutado': '', // CACHE
          "periodos": [
            {
              "periodoId": '',
              "fechaIniPeriodo": '',
              "fechaFinPeriodo": '',
              "porcentajeProyectado": ''
            },
            {
              "periodoId": '',
              "fechaIniPeriodo": '',
              "fechaFinPeriodo": '',
              "porcentajeProyectado": '',
            }
          ],
          "actividades": [
            {
              "actividadId": 1,
              "descripcionActividad": "Actividad 1",
              "unidadMedida": "Ml",
              "valorUnitario": 1000000,
              "cantidadProgramada": 10.0,
              "cantidadEjecutada": 3.0,
              "valorProgramado": 10000000,
              "valorEjecutado": 3000000,
              "porcentajeAvance": 30.0,

              'txtActividadAvance': '' //CACHE
            },
          ],
          "indicadoresAlcance": [
            {
              "indicadorAlcanceId": 1,
              "descripcionIndicadorAlcance": "Indicador Alcance 1",
              "unidadMedida": "Ml",
              "cantidadProgramada": 10.0,
              "cantidadEjecutada": 3.0,
              "porcentajeAvance": 30.0,

              'txtEjecucionIndicadorAlcance': '' //CACHE
            }
          ],
          "apectosEvaluar": [
            {
              "aspectoEvaluarId": 1,
              "descripcionAspectoEvaluar": "Administrativo"
            },
            {"aspectoEvaluarId": 2, "descripcionAspectoEvaluar": "Financiero"},
            {"aspectoEvaluarId": 3, "descripcionAspectoEvaluar": "Técnico"},
            {"aspectoEvaluarId": 4, "descripcionAspectoEvaluar": "Jurídico"},
            {"aspectoEvaluarId": 5, "descripcionAspectoEvaluar": "Social"}
          ],
          /* CACHE */
          'avancesCualitativos': [
            {
              'aspectoEvaluarId': '',
              'titulo': '',
              'logro': '',
              'dificultad': ''
            }
          ],
          /* fin CACHE **/
          "tiposFactorAtraso": [
            {"tipoFactorAtrasoId": 1, "tipoFactorAtraso": "Administrativos"},
            {"tipoFactorAtrasoId": 2, "tipoFactorAtraso": "Ambientales"},
            {"tipoFactorAtrasoId": 3, "tipoFactorAtraso": "Contratación"},
            {"tipoFactorAtrasoId": 4, "tipoFactorAtraso": "Entregables"},
            {"tipoFactorAtrasoId": 5, "tipoFactorAtraso": "Estudios y diseños"},
            {"tipoFactorAtrasoId": 6, "tipoFactorAtraso": "Financieros"},
            {
              "tipoFactorAtrasoId": 7,
              "tipoFactorAtraso": "Fraude y corrupción"
            },
            {"tipoFactorAtrasoId": 8, "tipoFactorAtraso": "Información"},
            {
              "tipoFactorAtrasoId": 9,
              "tipoFactorAtraso": "Mano de obra, materiales y equipos"
            },
            {
              "tipoFactorAtrasoId": 10,
              "tipoFactorAtraso": "Políticos y legales"
            },
            {"tipoFactorAtrasoId": 11, "tipoFactorAtraso": "Sociales"}
          ],
          "factoresAtraso": [
            {
              "factorAtrasoId": 1,
              "factorAtraso": "PERMISOS",
              "tipoFactorAtrasoId": 1
            },
            {
              "factorAtrasoId": 2,
              "factorAtraso": "PLANOS",
              "tipoFactorAtrasoId": 1
            },
            {
              "factorAtrasoId": 3,
              "factorAtraso": "TRÁMITES FIDUCIA",
              "tipoFactorAtrasoId": 1
            },
            {
              "factorAtrasoId": 4,
              "factorAtraso": "SOPORTES LIQUIDACIÓN",
              "tipoFactorAtrasoId": 1
            },
            {
              "factorAtrasoId": 5,
              "factorAtraso": "LICENCIAS",
              "tipoFactorAtrasoId": 1
            },
          ],

          /* CACHE */
          'factoresAtrasoSeleccionados': [
            {
              'tipoFactorAtrasoId': '',
              'tipoFactor': '',
              'factorAtrasoId': '',
              'factor': ''
            }
          ],
          'txtComentario': '',
          'fileFotoPrincipal': '',
          'filesFotosComplementarias': []
          /* fin CACHE **/
        }
      },
      {
        "codigoproyecto": '',
        "nombreproyecto": '',
        "valorproyecto": '',
        "valorejecutado": '',
        "porcentajeProyectado": '',
        "semaforoproyecto": '',
        "codigocategoria": '',
        "imagencategoria": '',
        "colorcategoria": '',
        "nombrecategoria": '',
        "objeto": '',
        "contratista": '',
        "pendienteAprobacion": '',
        "paso": ''
      },
    ]
  }
];
