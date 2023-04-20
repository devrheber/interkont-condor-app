# obtener argumentos de la línea de comandos
# $1: versión de la nueva versión

# si $1 es "prod" o "dev", entonces se establece la versión de la nueva versión
# a la versión de la versión actual

# obtener versión actual con grep en el archivo pubspec.yaml

# si $1 es diferente de prod o dev entonces mostrar error y salir caso contrario continuar
if [ "$1" != "prod" ] && [ "$1" != "dev" ]; then
    echo "Error: argumento de línea de comandos no válido"
    exit 1
fi


VERSION=$(grep -oP '(?<=version: ).*' pubspec.yaml)

# establecer la versión de la nueva versión aumentado en 1 el último número y en el último número antes del punto.
# por ejemplo, si la versión actual es 1.0.0+1, la nueva versión será 1.0.1+1
# si la versión actual es 1.0.1+1, la nueva versión será 1.0.2+2
# si la versión actual es 1.0.2+2, la nueva versión será 1.0.3+3
# crear la nueva versión y guardarla en la variable NEW_VERSION

NEW_VERSION=$(echo $VERSION | awk -F. '{print $1"."$2"."$3+1"+"$3+1}')

# esblecer la nueva versión en el archivo pubspec.yaml
sed -i "s/version: $VERSION/version: $NEW_VERSION/g" pubspec.yaml

# establecer la nueva versión en el archivo lib/constants/api_base_url.dart delante de la línea versionNumber
sed -i "s/String versionNumber = \"$VERSION\"/String versionNumber = \"$NEW_VERSION\"/g" lib/constants/api_base_url.dart

# fvm flutter clean; fvm flutter pub get; fvm flutter build apk
fvm flutter clean; fvm flutter pub get; fvm flutter build appbundle

# cambiar nombre del archivo apk según argumento de línea de comandos
# APP_NAME=$(grep -oP '(?<=name: ).*' pubspec.yaml)
APP_NAME="sienteplus"

if [ "$1" == "prod" ]; then
    mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-release-$APP_NAME-$NEW_VERSION-prod.apk
    mv build/app/outputs/bundle/release/app-release.aab build/app/outputs/bundle/release/app-release-$APP_NAME-$NEW_VERSION-prod.aab
elif [ "$1" == "dev" ]; then
    mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-release-$APP_NAME-$NEW_VERSION-dev.apk
    mv build/app/outputs/bundle/release/app-release.aab build/app/outputs/bundle/release/app-release-$APP_NAME-$NEW_VERSION-dev.aab
fi

# subir archivo apk a la carpeta de la versión actual en Google Drive
# si la carpeta de la versión actual no existe, crearla
# si la carpeta de la versión actual existe, subir el archivo apk a la carpeta de la versión actual como una versión nueva del archivo

