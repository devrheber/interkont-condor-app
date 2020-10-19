import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  
  static const Color primario = Color(0xFF673bb7);
  static const Color secundario = Color(0xFF9594F1);
  static const Color verdeOscuro = Color(0xFF8CC63E);
  static const Color verde = Color(0xFF42BC62);
  static const Color verdeClaro = Color(0xFF76BF4B);
  static const Color celeste = Color(0xFFE2EEFA);
  static const Color morado = Color(0xFF7E87C8);
  static const Color bottomPrincipal = Color(0xFFF2F7FB);
  static const Color itemSeleccionado = Color(0xFF50B5A7);
  static const Color itemDesactivado = Color(0xFF556C92);
  
  
  
  // static const Color primero = Color(0xFF0170bd);
  // static const Color segundo = Color(0xFF1ea782);
  static const Color primero = Color(0xFF002F5E);
  static const Color segundo = Color(0xFF41b16d);
  static const Color primarioBackground = Color(0xFF002F5E);
  static const Color segundoBackground = Color(0xFF575A9D);

  static const Color tercero = Color(0xFF8cc63f);

  static const Color cuarto = Color(0xFF673bb7);
  static const Color quinto = Color(0xFF3e51b5);
  static const Color sexto = Color(0xFF2196f3);
  static const Color septimo = Color(0xFF4ab9e5);
  static const Color octavo = Color(0xFF1dbcd2);
  static const Color noveno = Color(0xFF199788);
  static const Color decimo = Color(0xFF4cb050);
  static const Color onceavo = Color(0xFF8bc24a);
  static const Color doceavo = Color(0xFFbfbf2e);
  static const Color treceavo = Color(0xFFfd9700);

  static const Color catorceavo = Color(0xFF334660);
  static const Color quinceavo = Color(0xFF1a9d8c);
  static const Color dieciseisavo = Color(0xFF556a8d);
  static const Color diecisieteavo = Color(0xFF8cc63f);
  static const Color dieciochoavo = Color(0xFF24b477);

  static const Color rojoBackground = Color(0xFFDEDBE6);
  
  
  
  
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);  
  static const String fontName = 'montserrat';


  static const TextStyle h1 = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 17,
    color: Color(0xFF000000),
  );

  static const TextStyle h2 = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: Color(0xFF000000),
  );

  static const TextStyle peligro = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: 0.4,
    height: 1.9,
    color: Colors.red,
  );
  
  static const TextStyle tituloParrafo = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    letterSpacing: 0.4,
    height: 0.9,
    // color: catorceavo,
    color: dieciseisavo
  );
  
  static const TextStyle parrafo = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w200,
    fontSize: 12,
    // color: dieciseisavo,
    color: Color(0xFF556a8d)
  );

  static const TextStyle parrafoNegrita = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    // color: dieciseisavo,
    color: Color(0xFF505050)
  );

  static const TextStyle comentarioPlomo = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w200,
    fontSize: 14,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.grey,
  );

  static const TextStyle h1Blanco = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle h2Blanco = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 15,
    letterSpacing: 0.4,
    height: 0.9,
    color: Colors.white,
  );

  static const TextStyle parrafoBlanco = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w200,
    fontSize: 11,
    color: Colors.white,
  );

  static const TextStyle parrafoBlancoNegrita = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 11,
    color: Colors.white,
  );

  static const TextStyle parrafoRojo = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w200,
    fontSize: 11,
    color: Colors.red
  );

  static const TextStyle parrafoRojoNegrita = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: 11,
    color: Colors.red
  );

  static const TextStyle parrafoVerdeNegrita = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: 11,
    color: verde
  );

  static const TextStyle parrafoCelesteNegrita = TextStyle( 
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: 11,
    color: Color(0xff1EB8CF)
  );

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}