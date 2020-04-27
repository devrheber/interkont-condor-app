library my_prj.variables;

int posicionListaProyectosSeleccionado = 0;
String urlGlobal = 'http://13.59.62.87:8080';
String urlGlobalApiCondor = 'http://13.59.62.87:8080/cobra-ws-condor';
List contenidoWebService = [
  {
    'usuario' : {
      'idUsu'     : '0',
      'nombreUsu' : 'demo',
      'tokenUsu'  : 'token'
    },
    'proyectos' : [
      {
        "codigoproyecto"   : '',
        "nombreproyecto"   : '',
        "valorproyecto"    : '',
        "valorejecutado"   : '',
        "semaforoproyecto" : '',
        "codigocategoria"  : '',
        "imagencategoria"  : '',
        "nombrecategoria"  : '',
      },
      {
        "codigoproyecto"   : '',
        "nombreproyecto"   : '',
        "valorproyecto"    : '',
        "valorejecutado"   : '',
        "semaforoproyecto" : '',
        "codigocategoria"  : '',
        "imagencategoria"  : '',
        "nombrecategoria"  : ''
      },
    ]
  }
];