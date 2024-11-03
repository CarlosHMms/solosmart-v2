# Projeto SoloSmart - Backend em Laravel e Frontend em Flutter

Este projeto visa fornecer uma solução completa para monitoramento e gerenciamento de plantações usando um backend em Laravel e um frontend em Flutter. O Laravel é responsável pela API RESTful e autenticação, enquanto o Flutter fornece a interface do usuário para mobile.


# Índice
- [Pré-requisitos](#pré-requisitos)
- [Configuração do Backend (Laravel)](#configuração-do-backend-laravel)
- [Configuração do Frontend (Flutter)](#configuração-do-frontend-flutter)
- [Como Executar o Projeto](#como-executar-o-projeto)
- [Funcionalidades Principais](#funcionalidades-principais)
-  [Licença](#licença)

## Pré-requisitos

- **PHP 8.3+** (com Composer)
-  **Laravel 11+**
-  **MySQL**
- **Flutter 3.24.3**
- **Dart SDK**
- **Git** (para versionamento de código)

## Configuração do Backend (Laravel)

1. Clone este repositório e acesse a pasta:
```bash
git clone https://github.com/CarlosHMms/solosmart-v2.git
```
```bash
cd solosmart-v2
```
2. Instale as dependências do Laravel:
```bash
composer install
```
3. Crie o arquivo `.env` com as configurações do ambiente e gere a chave do aplicativo:
```bash
cp .env.example .env
```
```bash
php artisan key:generate
```
4. Configure o banco de dados no arquivo `.env`:
```bash
DB_CONNECTION=mysql 
DB_HOST=localhost 
DB_PORT=3306 
DB_DATABASE=solosmart_v2 
DB_USERNAME=seu_usuario 
DB_PASSWORD=sua_senha
```
5. Execute as migrações para gerar e subir as tabelas para o banco:
```bash
php artisan migrate
```
6. Crie um link simbólico para a pasta no qual são salvas as imagens de perfil:
```bash
php artisan storage:link
```
7. Inicie o servidor de desenvolvimento:
```bash
php artisan serve
```

## Configuração do Frontend (Flutter)

1.  Acesse a pasta do frontend do projeto:
```bash
cd solosmart_flutter
```
2.  Instale as dependências do Flutter:
```bash
flutter pub get
```
## Como Executar o Projeto

1. Primeiro, certifique-se de que o backend Laravel está em execução:
```bash
php artisan serve
```
2. Em seguida, dentro da pasta do frontend execute o app Flutter em um emulador ou dispositivo:
```bash
flutter run
```

## Funcionalidades Principais

- **Backend em Laravel**: Fornece APIs RESTful para autenticação, gerenciamento de usuários e manipulação dos dados da plantação.
- **Frontend em Flutter**: Interface amigável que permite a visualização e manipulação dos dados de monitoramento e controle de irrigação.
- **Autenticação**: Registro e login de usuários utilizando o Laravel Breeze para uma experiência de autenticação simplificada.


# Licença

Este projeto está licenciado sob a Licença MIT.
