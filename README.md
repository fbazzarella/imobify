# New App

Este guia destina-se apenas à instalação e execução do sistema em modo desenvolvimento.

## Instalação

O sistema utiliza a linguagem Ruby em sua versão 2.1.x, o framework Ruby on Rails em sua versão 4.0.x e banco de dados PostgreSQL em sua versão 9.2.x.

Clone o repositório:

    $ git clone git@bitbucket.org:fbazzarella/newapp.git

Instale as dependências:

    $ cd newapp
    newapp$ bundle install

## Configuração

Copie o arquivo `config/database.yml.example` para `config/database.yml` e preencha-o de acordo com suas configurações. Após, basta criar o banco e rodar as migrations:

    newapp$ rake db:create db:migrate

## Execução

Agora basta iniciar o servidor para que o sistema esteja rodando:

    newapp$ rails server

## Testes

Os testes automatizados são escritos em RSpec e utilizam FactoryGirl para a criação de registros. Antes de rodar os testes, você precisará preparar o banco de dados:

    newapp$ rake db:test:prepare
    
Agora, rode os testes:

    newapp$ rspec spec/

### Usando o Guard

Alternativamente, você poderá usar o Guard para rodar os testes automaticamente ao salvar um arquivo. Antes de iniciar o Guard, você deverá iniciar o Zeus em uma janela separada no terminal:

    newapp$ zeus start

Agora, basta iniciar o Guard:

    newapp$ guard
    
### Atenção

É extremamente importante enviar ao repositório somente commits que estejam com todos os testes em verde. Essa atitude evita problemas no futuro, economizando tempo e paciência.
