// TODO Flavors

// Avánzame
// String _baseUrlPruebas = 'https://avanzamepruebas.minenergia.gov.co';
// String _baseUrlProduccion = 'https://backendavanzame.minenergia.gov.co';

String _baseUrlPruebas = 'http://13.59.62.87:7073/siente3-ws-consulta';
String _baseUrlProduccion = 'https://sienteapp.gestiondelriesgo.gov.co';
String _app = 'siente3-ws';
// https://sienteapp.gestiondelriesgo.gov.co/siente3-ws
String _baseUrl = '$_baseUrlPruebas/$_app';

// String urlGlobalApiCondor = '$_baseUrl/$_app';
String urlGlobalApiCondor = _baseUrl;
String urlApiAom = '$_baseUrl/avanzaweb-ws-AOM';
String urlFiles = '$_baseUrl/files-ws';
String urlBaseWeb = '$_baseUrl/avanzaweb-ws';

// TODO
String versionNumber = "2.0.3+3";
