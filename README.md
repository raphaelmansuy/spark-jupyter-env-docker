# A docker-compose with scala and spark and jupiterlab

[![CodeFactor](https://www.codefactor.io/repository/github/raphaelmansuy/spark-jupyter-env-docker/badge)](https://www.codefactor.io/repository/github/raphaelmansuy/spark-jupyter-env-docker)

## A local dev environment for Scala, Spark, Jupyter notebook, vault, postgres and minio

Created with â¤ï¸

### This project helps you to create a big data stack with

- Spark
  - 1 master node
  - 2 worker
- Jupyterlab
  - Python
  - Scala
  - R
- Postgres


#### Logical architecture

![Architecture](documentation/architecture.svg)


#### Detailed architecture

![Detailed architecture](documentation/docker-compose.png)


### Based on

- [Almond](https://almond.sh/) A Scala Kernel for Jupiter ð§ 
- [Jupiterlab](https://jupyter.org/) Jupiter Lab ðª
- [Spark](https://spark.apache.org/) Spark â¡ï¸
- [Minio](https://min.io/) Minio S3 compatble object storage  ðª
- [Hashicorp Vault](https://www.vaultproject.io/) A secret manager Â Â ð

## How to start

Clone the repository

```bash
git clone https://github.com/raphaelmansuy/spark-jupyter-env-docker
```

Enter the project directory

```bash
cd spark-jupyter-env-docker
```

## Build the images

```bash
./build.sh
```

## Start the stack

```bash
docker-compose up --build
```

### The stack is running ðÂ ð

#### Open Jupiterlab

open [http://localhost:8888](http://localhost:8888)

![Jupiterlab](./documentation/juopiterlab.png)

#### Open SparkUI

Open [http://localhost:8080](http://localhost:8080)

### Access to minio (high-performance, S3 compatible object storage)

Open [http://localhost:9001](http://localhost:9001)

ð§ user: minioadmin
ð password: minioadmin

## Access to vault (Secret manager)

Open [http://127.0.0.1:8200](http://127.0.0.1:8200/)

ð token myrootid

### To delete the stack and destroy volumes

 ð£ This instruction delete all the containers and their volumes

```bash
docker-compose down --volumes
```

VoilÃ  ð
