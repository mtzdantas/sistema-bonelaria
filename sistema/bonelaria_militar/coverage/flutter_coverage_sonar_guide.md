# 📈 Como gerar coverage no Flutter e enviar para o SonarQube

Este guia mostra como rodar testes com cobertura no Flutter, converter o arquivo `lcov.info` para o formato Cobertura XML (necessário para o SonarQube) e enviar o resultado com o `sonar-scanner`.

---

## ✅ Pré-requisitos

Certifique-se de ter instalado:

- Flutter
- Python 3
- Biblioteca `lcov_cobertura`:
  ```bash
  pip install lcov_cobertura
  ```
- `sonar-scanner`
- Um arquivo `sonar-project.properties` corretamente configurado na raiz do projeto

---

## 🧪 1. Gerar o coverage com Flutter

Na raiz do projeto, rode:

```bash
flutter test --coverage
```

Isso irá gerar o arquivo `coverage/lcov.info`.

---

## 🔄 2. Converter `lcov.info` para `coverage.xml`

Entre na pasta `coverage`:

```bash
cd coverage
```

Agora rode o comando abaixo no terminal:

```bash
lcov_cobertura lcov.info
```

Esse comando vai gerar automaticamente o arquivo `coverage.xml` na mesma pasta.

---

## 📤 3. Enviar para o SonarQube

Volte para a raiz do projeto:

```bash
cd ..
```

Execute o scanner:

```bash
sonar-scanner
```

O `sonar-scanner` irá utilizar o arquivo `coverage.xml` para importar os dados de cobertura de testes.

---

## 🧾 Exemplo de `sonar-project.properties`

Certifique-se que o seu arquivo `sonar-project.properties` tenha pelo menos:

```properties
sonar.projectKey=seu_projeto
sonar.projectName=Seu Projeto Flutter
sonar.sources=lib
sonar.language=dart
sonar.sourceEncoding=UTF-8
sonar.coverageReportPaths=coverage/coverage.xml
```

---

✅ Pronto! Agora você consegue visualizar a cobertura de testes do seu projeto Flutter direto no SonarQube!