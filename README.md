# A docker-compose with scala and spark and jupiterlab

### This recipes help you create a local dev environment for Scala, Spark and Jupyter notebook

This project helps you to create a local stack with

- Spark
    - 1 master node
    - 2 worker
- Jupyterlab
    - Python
    - Scala
    - R
- Postgres

![Architecture](A%20docker-compose%20with%20scala%20and%20spark%20cdedadd6899b4d0d93571de9cf27eecb/Untitled.png)

[Architecture Excalidraw](https://excalidraw.com/#room=89d7b8ce88bd1dc8fbdc,jJoaMBfsQHDcqN9P2KLGyw)



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

The stack is running 🎉 🚀

- Open Jupiterlab
    
    open [http://localhost:8888](http://localhost:8888)
    
    ![Jupiterlab](A%20docker-compose%20with%20scala%20and%20spark%20cdedadd6899b4d0d93571de9cf27eecb/Untitled%201.png)
    
- Open SparkUI
    - Open [http://localhost:8080](http://localhost:8080)
    
    ![Spark UI](A%20docker-compose%20with%20scala%20and%20spark%20cdedadd6899b4d0d93571de9cf27eecb/Untitled%202.png)
    
    Voilà 🚀
