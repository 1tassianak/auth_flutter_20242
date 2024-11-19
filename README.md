#App exemplo de autenticação com Flutter e Firebase, com o login persistente

# Gerando um APK no Flutter

Este guia detalha os passos necessários para gerar um APK de um aplicativo Flutter.

---

## 1. Após o desenvolvimento do app, Atualize o Número da Versão:

```yaml
version: 1.0.0+1
```

- O formato é major.minor.patch+build.

### 2. Configure a Assinatura do Aplicativo:

- Para distribuir o aplicativo na Google Play Store, é necessário assiná-lo digitalmente.
- Crie um arquivo de chave (keystore) executando:

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

- Siga as instruções para definir uma senha e outras informações.
- Crie um arquivo key.properties no diretório android do seu projeto com o seguinte conteúdo:

```properties
storePassword=senha_definida
keyPassword=senha_definida
keyAlias=upload
storeFile=caminho/para/upload-keystore.jks
```
- No arquivo android/app/build.gradle, adicione as seguintes linhas:

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```
- Para mais detalhes sobre a assinatura de aplicativos, consulte a documentação oficial: [Assinatura de Aplicativos Android](https://docs.flutter.dev/deployment/android#signing-the-app).

### 3. Compilar o APK em Modo Release:

- No terminal, execute: 

```bash
flutter build apk --release
```

- O APK gerado estará localizado em build/app/outputs/flutter-apk/app-release.apk.

### 4. Distribuição do APK

- O APK gerado pode ser instalado manualmente em dispositivos Android.
- Para distribuir o APK na Google Play Store, siga o processo de publicação do Google Play Console.
