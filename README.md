# Imobify

Este guia destina-se apenas à instalação e execução do sistema em modo desenvolvimento.

## Instalação

O sistema utiliza a linguagem Ruby em sua versão 2.2.x, o framework Ruby on Rails em sua versão 4.2.x e bancos de dados PostgreSQL em sua versão 9.4.x e Redis em sua versão 3.0.x.

Clone o repositório:

    $ git clone git@bitbucket.org:fbazzarella/imobify.git
    $ cd imobify

Instale as dependências:

    imobify$ bundle install

## Configuração

Copie o arquivo `config/database.yml.example` para `config/database.yml` e preencha-o de acordo com suas configurações. Após, basta criar o banco e rodar as migrations:

    imobify$ rake db:create db:migrate

## Execução

Agora basta iniciar o servidor para que o sistema esteja rodando:

    imobify$ rails server

## Testes

Os testes automatizados são escritos em RSpec e utilizam FactoryGirl para a criação de registros. Antes de rodar os testes, você precisará preparar o banco de dados:

    imobify$ rake db:test:prepare
    
Agora, rode os testes:

    imobify$ rspec spec/

### Atenção

É extremamente importante enviar ao repositório somente commits que estejam com todos os testes em verde. Essa atitude evita problemas no futuro, economizando tempo e paciência.
