@ECHO OFF
ECHO GENERANDO BUNDLE
ECHO Limpiando caché
flutter clean && flutter pub get 
PAUSE
flutter build appbundle