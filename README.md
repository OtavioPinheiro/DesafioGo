# Desafio GO
O desafio consiste em gerar uma imagem Golang que quando acessada retorna para o usuário a mensagem: `FullCycle Rocks!`. A imagem gerada não pode ultrapassar 2 MB.

# Imagem GO
[Imagem GO no DockerHub](https://hub.docker.com/r/171793/desafio_go)

## Código GO
[Main.go](./main.go)

## Dockerfile
[Dockerfile](./Dockerfile)

### Explicações do Dockerfile
```Dockerfile
FROM golang:alpine3.10 as builder

WORKDIR /go/scr/app

COPY . .

RUN CGO_ENABLED=0 go build -o /app main.go


FROM scratch

COPY --from=builder /app /app

CMD ["/app"]
```

1. Baixe a imagem oficial da Golang do DockerHub, versão alpine 3.10. Use-a como imagem construtora.
2. Defina o diretório de trabalho.
3. Copie os arquivos (main.go) do diretório atual da máquina para o diretório do *container*.
4. Execute o comando para construir a aplicação GO.
5. FROM scratch significa para criar uma imagem super mínima, contendo apenas um binário e o necessário para ser executado.
6. Processo de *Multistage build*, onde será usada a imagem intermediária ou construtora (a *builder*) que foi responsável por construir e compilar a aplicação GO. A imagem construtora irá passar para a imagem final (a *scratch*) a aplicação GO já compilada.
7. Acesse a pasta `/app` para executar a aplicação compilada.

### Construção e Execução
Para construir a imagem faça:
- `docker build -t <dockerhub_id>/<tag_do_projeto> .`

Para executar faça:
- `docker run <dockerhub_id>/<tag_do_projeto>`

**OU**, para usar a minha imagem pronta, faça isso:
- `docker run 171793/desafio_go`

## Resultado
Executando o comando `docker images` vemos que a imagem gerada tem `2.01 MB` de tamanho.

# Fontes consultadas
- Docker Hub. [FROM scratch](https://hub.docker.com/_/scratch#:~:text=0%20(specifically%2C%20docker%2Fdocker,1%2Dlayer%20image%20instead).&text=You%20can%20use%20Docker's%20reserved,starting%20point%20for%20building%20containers.)
- Pascal Zwikirsch. [Optimize the size of your Dockerized Go Application Down To 2MB!](https://levelup.gitconnected.com/optimize-the-size-of-your-dockerized-go-application-down-to-2mb-7b826ecb062d)
- Adnan Rahic. [Como otimizar imagens Docker para produção](https://www.digitalocean.com/community/tutorials/como-otimizar-imagens-docker-para-producao-pt)
- Allan Barbosa. [Golang - Criando imagens docker like a boss](https://medium.com/allbarbos/golang-criando-imagens-docker-like-a-boss-563e48941203)