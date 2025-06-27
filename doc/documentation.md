# Documentação

## Sobre o LandingZone do GCP

## Pré-Requisitos para executar um Landingzone

Para realizar um Landingzone é necessário 

## Componentes Essenciais para um LandingZone no GCP

- <b>Hierarquia Organizacional</b>: 
- <b>Identity and Access Management (IAM)</b>:
- <b>Arquitetura da Rede</b>: Topologias típicas, como Shared VPC (criada para cada de ambiente, como Produção, Teste, Homologação), VPN, NAT (para habilitar acesso externo), além da definição do firewall (assegurar a conectividade para os fluxos de trabalho, além de proteger os acessos). A boa modelagem da arquitetura de rede é uma peça essencial para um landzone.
- <b>Segurança e Compliance</b>:
- <b>Monitoramento e Logs</b>:


<div style="text-align: center;  ">
  <img src="../images/estrutura_landingzone_gcp.webp" alt="Texto Alternativo" width="500">
</div>

## Estrutura Funcional parte a parte do LandingZone

O diagrama estrutural a nível de aplicação foi modelado com aspectos generalistas a serem escalados de acordo com a evolução do modelo. Mais abaixo os tópicos são aboardados e aprofundados. Esta é uma representação de um modelo Organizacional.

### Design de Organização

<div style="text-align: center;  ">
  <img src="../images/diagramaParasolucagenerica.png" alt="Texto Alternativo" width="500">
</div>

### Bootstrap

Este projeto representa o Bootstrap do ambiente, que em suma será responsável pela organização e configurações iniciais do GCP(políticas iniciais da organização, hierarquia de pastas, entre outros), além de guardar algumas variáveis secretas, como id's dos projetos, billing account, id da organização.

É importante salientar que as estruturas secretas precisam ser armazenadas em "envs", ignorando seus commits à estrutura principal (utilizando o .gitignore é possível fazer isso), para evitar vazamentos de informações. 





## Links úteis


<la>
    <li><a href="https://medium.com/google-cloud/hands-on-gcp-landing-zone-with-terraform-code-44393a776139">Landing zone design in Google Cloud: Hands-on Demo with Terraform<a>
    <ul style="text-decoration: none; color: white;">Construção de um Landing Zone no GCP utilizando arquitetura modular.</ul></li>
    <li><a href="https://github.com/ollionorg/gcp-landing-zone">GCP-landing-zone<a>
    <ul style="text-decoration: none; color: white;">Repositório com implementação de um landingzone. No atual momento, este repositório não recebeu mais atualizações, são 1 ano e alguns meses sem novas implementações. Necessário realizar testes para verificar possíveis falhas de segurança.</ul></li>
    <li><a href="https://medium.com/google-cloud/your-first-step-in-google-cloud-platform-building-a-landing-zone-with-terraform-d9fe764edbcb">Your First Step in Google Cloud Platform : Building a Landing Zone with Terraform<a>
    <ul style="text-decoration: none; color: white;">Artigo com princípios fundamentais de uma Landzone, voltado para o GCP com Terraform. Mais introdutório.</ul></li>
    <li><a href="https://medium.com/google-cloud/everything-about-google-cloud-landing-zone-19ccd90af844">Everything About Google Cloud Landing Zone <a><ul style="text-decoration: none; color: white;">Artigo com princípios fundamentais de uma Landzone, com conceitos técnicos, voltado para o GCP.</ul></li>
    <li><a href="https://developer.hashicorp.com/terraform/docs">Terraform Documentation<a> <ul style="text-decoration: none; color: white;">Documentação do Terraform.</ul></li>
    <li><a href="https://github.com/terraform-google-modules/terraform-example-foundation">Terraform-example-foundation<a> <ul style="text-decoration: none; color: white;">Exemplo da Google de melhores práticas e performance para um Landingzone.</ul></li>



    
</la>

