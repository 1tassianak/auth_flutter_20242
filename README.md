# Autenticação

### App exemplo de autenticação com Flutter e Firebase, com o login persistente

## Listagem de funções por telas

### Tela de login

- Faz conexão com o FirebaseAuth
- Função Login:
  - Tenta autenticar no banco através do UserCredential e redireciona para a tela Home
  - Caso não der certo, faz o tratamento dos seguintes erros:
    - 'user-not-found': Usuário não encontrado
    - 'wrong-password': Senha incorreta
    - 'invalid-email': E-mail inválido
    - 'user-disabled': Conta desativada
    - 'too-many-requests':Muitas tentativas de login 
    - default: para outros erros inesperados

- Função registrar:
  - Tenta registrar, o e-mail e senha digitados, no banco através do UserCredential, exibe uma mensagem de sucesso e redireciona para a tela Login
  - Caso não der certo, faz o tratamento dos seguintes erros:
    - 'email-already-in-use': Este e-mail já está em uso
    - 'invalid-email': O e-mail é inválido
    - 'operation-not-allowed': O registro com e-mail e senha foi desativado
    - 'weak-password':A senha é muito fraca
    - default: para outros erros inesperados

- Funções para criação da tela e exibição dos inputs de e-mail e senha, e dos botões de login e registro

### Tela Home

- Exibe um texto informando que está na tela Home
- Exibe um botão com a função de Logout:
  - Tenta fazer logout, avisa o usuário que desconectou e redireciona para a tela de Login
  - Caso contrário, exibe um erro imprimindo a mensagem informativa.

## Listagem de dependências utilizadas

- cloud_firestore: ^5.5.0
- firebase_core: ^3.8.0
- firebase_auth: ^5.3.3

## Instruções para configuração/importação do projeto

### Versões utilizadas do Flutter e Dart

- Flutter 3.24.4 
- Dart 3.5.4

### Versão mínima do SDK

- minSdk = 23

### Importando o projeto

- Baixe o código-fonte do projeto
- No Android Studio, abra o projeto baixado
- Vá em Settings e verifique se em "Languages e Frameworks > Flutter" a configuração Flutter SDK path contém o caminho correto para acessar o SDK que está no seu computador
- Abra o arquivo "pubspec.yaml" e clique em "Pub get" para baixar as dependências do projeto
- Inicie um emulador e execute o projeto
- Para testar, digite um e-mail e senha e clique em "Registrar", depois faça o login com a conta recém criada.

#

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
