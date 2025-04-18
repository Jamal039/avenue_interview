# Avenue Interview Project

Esse projeto é um aplicativo que mostra a cotação do Dollar atual, e uma lista da cotação do Dollar dos últimos 15 dias.

Um dos desafios de qualquer time de desenvolvimento é lidar com código legado e na Avenue isso não é diferente. Um dos objetivos de trazer os melhores desenvolvedores do Brasil é atacar o problema. Para isso, essa etapa do processo consiste numa proposta de solução para o desafio abaixo e você pode escolher a melhor forma de resolvê-lo, de acordo com sua comodidade e disponibilidade de tempo:

 - Resolver o desafio previamente, e explicar sua abordagem no momento da entrevista. 
 - Discutir as possibilidades de solução durante a entrevista, fazendo um pair programming (bate-papo) interativo com os nossos devs.

Com o passar do tempo identificamos alguns problemas que impedem esse aplicativo de escalar e acarretam problemas de experiência do usuário. A partir disso elaboramos a seguinte lista de requisitos que devem ser cumpridos ao melhorar nossa arquitetura:

 - Aqui nós damos preferencia ao gerenciamento de estado com o [Cubit](https://medium.com/@muhammadnaqeeb/cubit-state-management-in-flutter-cb3d357fd0f0), mas você pode usar o que achar melhor.
 - Nossos relatórios de crash têm mostrado alguns crashes relacionados a campos que não deveriam ser nulos sendo nulos e gerenciamento de lifecycle. Gostaríamos que fossem corrigidos. 
 - Gostaríamos de cachear os dados retornados pelo servidor.
 - Haverá mudanças na lógica de negócios e gostaríamos que a arquitetura reaja bem a isso. Aqui na Avenue nós damos preferencia a arquiteturas usando Clean Architecture, mas você pode usar o que achar melhor.
 - Haverá mudanças na lógica de apresentação. Gostaríamos que a arquitetura reaja bem a isso.
 - Agora estamos usando uma tabela para a cotação do dolar, isso deixa a UI muito carregada, gostaríamos de mudar para um gráfico. (Opcional)
 - Seria interessante o app suportar outras linguagens, como inglês e espanhol. (Opcional)
 - Seria interessante listar as libs que foram adicionadas aqui no readme. (Opcional)
 - Seria interessante adicionar testes automatizados, via CI/CD. (Opcional)
 - Seria interessante o app da suporte de upload de imagem no perfil do cliente. (Opcional)
 - Com um grande número de desenvolvedores e uma quantidade grande de mudanças ocorrendo testes automatizados são essenciais.
   - Gostaríamos de ter testes unitários testando nossa lógica de apresentação, negócios e dados independentemente, visto que tanto a escrita quanto execução dos mesmos são rápidas.
   - Por outro lado, testes unitários rodam em um ambiente de execução diferenciado e são menos fiéis ao dia-a-dia de nossos usuários.
