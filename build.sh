#!/bin/bash
#
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

BUILD_DATE="$(date -u +'%Y-%m-%d')"

JUPYTERLAB_VERSION="3.4.3"
SPARK_VERSION="3.0.0"
HADOOP_VERSION="3.2"
SCALA_VERSION="2.12.10"
SCALA_KERNEL_VERSION="0.10.9"

POSTGRES_VERSION="13.0"


# ----------------------------------------------------------------------------------------------------------------------
# -- Functions----------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------



function cleanContainer() {
  containerName=$1
  container=$(docker ps -a | grep ${containerName} -m 1 | awk '{print $1}')
  while [ -n "${container}" ];
  do
    echo "👉 cleaning container ${containerName}"
    docker stop "${container}"
    docker rm "${container}"
    echo " ✅ container ${containerName} stopped and deleted"
    container=$(docker ps -a | grep ${containerName} -m 1 | awk '{print $1}')
  done 
}

function cleanImage() {
  imageName=$1
  image=$(docker images -a | grep ${imageName} -m 1 | awk '{print $3}')
  while [ -n "${image}" ];
  do
    echo "👉 cleaning image ${imageName}"
    docker rmi -f "${image}"
    echo " ✅ image ${imageName} deleted"
    image=$(docker images -a | grep ${imageName} -m 1 | awk '{print $3}')
  done 
}

function cleanVolume() {
  volumeName=$1
  volume=$(docker volume ls | grep ${volumeName} -m 1 | awk '{print $2}')
  echo "👉 deleting volume $volumeName"
  while [ -n "${volume}" ];
  do 
    docker volume rm "${volume}"
    echo " ✅ volume ${volume} deleted"
    volume=$(docker volume ls | grep ${volume} -m 1 | awk '{print $2}')
  done 
}

function cleanImages() {
  for i in jupyterlab spark-worker spark-master spark-base base postgres minio-srv
  do
    cleanImage $i
  done
}

function cleanContainers() {
  for i in jupyterlab spark-worker spark-master spark-base base postgres minio-srv
  do
    cleanContainer $i
  done
}


function cleanVolumes() {
  for i in hadoop-distributed-file-system db minio_data
  do
    cleanVolume $i
  done 
}

function buildImages() {

    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg scala_version="${SCALA_VERSION}" \
      -f docker/base/Dockerfile \
      -t base:latest .

    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg spark_version="${SPARK_VERSION}" \
      --build-arg hadoop_version="${HADOOP_VERSION}" \
      -f docker/spark-base/Dockerfile \
      -t spark-base:${SPARK_VERSION} .

    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg spark_version="${SPARK_VERSION}" \
      -f docker/spark-master/Dockerfile \
      -t spark-master:${SPARK_VERSION} .

    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg spark_version="${SPARK_VERSION}" \
      -f docker/spark-worker/Dockerfile \
      -t spark-worker:${SPARK_VERSION} .

    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg scala_version="${SCALA_VERSION}" \
      --build-arg spark_version="${SPARK_VERSION}" \
      --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
      --build-arg scala_kernel_version="${SCALA_KERNEL_VERSION}" \
      -f docker/jupyterlab/Dockerfile \
      -t jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION} .


     docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg postgres_version="${POSTGRES_VERSION}" \
      -f docker/postgres/Dockerfile \
      -t postgres .

     docker build \
      --build-arg build_date="${BUILD_DATE}" \
      -f docker/dremio/Dockerfile \
      -t dremio .


}

banner() {
  echo "💫 ELITIZON Spark Stack ...."
  echo "🤘 Let's build a Wonderfull Big Data Stack ...."
  echo "-----------------------------------------------"
}

footer() {
  echo "✅ Done "
  echo "👉 To start the stack type : docker-compose up --build"
  echo "💣 To delete the stack type: docker-compose down --volumes"
  echo "👋 Bye, see you soon 🎉"
}

# ----------------------------------------------------------------------------------------------------------------------
# -- Main --------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

banner;
cleanContainers;
cleanImages;
cleanVolumes;
buildImages;
footer;
