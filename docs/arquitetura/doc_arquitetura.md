# Projeto Arquitetural do Software

Documento construído a partido do **Modelo BSI - Doc 005 - Documento de Projeto Arquitetual do Software** que pode ser encontrado no
link:https://docs.google.com/document/d/1i80vPaInPi5lSpI7rk4QExnO86iEmrsHBfmYRy6RDSM/edit?usp=sharing

## Descrição da Arquitetura do Projeto

A arquitetura do Sistema da Bonelaria Militar segue um modelo cliente-servidor, com o frontend em Flutter para mobile e o backend utilizando o Supabase, que fornece autenticação, banco de dados relacional e API RESTful integrada baseada em PostgreSQL. O banco de dados é hospedado e gerenciado diretamente pelo Supabase, dispensando a necessidade de configurar containers manualmente.

Essa estrutura permite uma separação clara entre a interface do usuário (mobile) e a lógica de processamento e armazenamento (backend), mantendo uma arquitetura moderna, escalável e simplificada.

## Visão Geral da Arquitetura

Imagem com a organização geral dos componentes da arquitetura do projeto. Segue a Arquitetura Geral do Projeto utilizando **Flutter** no Front-End, e **Supabase** com **PostgreSQL** no Back-End para gerenciamento de dados, autenticação e comunicação via API RESTful:


![Arquitetura Django Framework](./Front-End%20(1).png)


A arquitetura do Sistema da Bonelaria Militar é composta por duas camadas principais: **Front-End** e **Back-End**.

### Front-End

O **Front-End** é responsável pela interface do usuário e pela interação com o sistema. Usamos **Flutter** para o desenvolvimento de aplicativo mobile.

### Back-End

O **Back-End** é responsável pela lógica de negócios, manipulação de dados e comunicação com o banco de dados. Utilizamos o **Supabase**, uma plataforma open-source que oferece uma alternativa ao **Firebase**, baseada no **PostgreSQ**L.

O Supabase fornece uma API RESTful e em tempo real automaticamente gerada a partir do banco de dados **PostgreSQL**, facilitando o gerenciamento de autenticação, leitura e escrita de dados diretamente do front-end.


## Requisitos Não-Funcionais

Requisitos não-funcionais que impactam na arquitetura. Nesta seção do documento, é necessário listar os requisitos não funcionais encontrados no sistema, tais como: portabilidade, usabilidade, desempenho e etc. O objetivo é colocar o nome do requisito e descrever com detalhes suas características.

Segue um exemplo:

Requisito  | Detalhes
---------- | -------------------------------------------- 
Desempenho | 1. A página principal tem que ser carregada em no máximo 3 segundos em uma conexão mínima de 256kbps. <br />2. As páginas que recuperam informações de sistemas legados, devem responder em dois segundos em uma conexão de 256kbps. <br />3. As páginas que recuperam informações de transações no banco de dados da própria aplicação, deve responder em um segundo usando paginação real (limit e offset), retornados em uma conexão de 256kbps. <br />4. O servidor deve suportar 100.000 conexões simultâneas sem perda de desempenho.
Interoperabilidade | 1. Deve ser desenvolvido no sistema linux, criando uma imagem docker do sistema e com banco de dados PostgreSQL 16.

## Mecanismos arquiteturais

Nesta seção do documento, devemos listar os mecanismos arquiteturais encontrados no sistema, ou seja, identificar todos os mecanismos de análise, mecanismo de design e mecanismo de implementação. O intuito desta etapa é verificar e garantir que todas as preocupações técnicas relativas à arquitetura do sistema tenham sido capturadas.

Exemplo:

| Mecanismo de Análise | Mecanismo de Design  | Mecanismo de Implementação |
| -------------------- | -------------------- | -------------------------- |
| Persistência         | Banco de dados relacional | PostgreSQL 16.2       |
| Camada de Dados      | Mapeamento OR             | Django ORM            |
| Frontend  | Interface Usuário | Django Templates, HTML5, JS, Bootstrap 5 |
| Backend              | REST                  | Django REST Framework     |
| Build                | Imagem Docker            | Docker e Dockerfile    |
| Deploy               | Container Docker         | Docker compose         |

# Implantação

O arquiteto deve descrever as configurações de distribuição dos componentes de software na área física em que serão implantados.

# Referências

Links utilizados como referência sobre Arquitetura de Software e documentação de Arquiteturas.

https://edisciplinas.usp.br/pluginfile.php/134335/mod_resource/content/1/Aula13_ArquiteturaSoftware_02_Documentacao.pdf

http://www.linhadecodigo.com.br/artigo/3343/como-documentar-a-arquitetura-de-software.aspx

http://diatinf.ifrn.edu.br/prof/lib/exe/fetch.php?media=user:1301182:disciplinas:arquitetura:exemplo-arquitetura-01.pdf

Peter Eeles; Peter Cripps. The Process of Software Architecting, Addison-Wesley Professional, 2009.

Paul Clements; Felix Bachmann; Len Bass; David Garlan; James Ivers; Reed Little; Paulo Merson; Robert Nord; Judith Stafford. Documenting Software Architectures: Views and Beyond, Second Edition, Addison-Wesley Professional, 2010.
