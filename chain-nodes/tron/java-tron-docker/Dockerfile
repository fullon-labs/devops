FROM tronprotocol/centos7:0.2

ENV TMP_DIR="/tron-build"
ENV JDK_TAR="jdk-8u202-linux-x64.tar.gz"
ENV JDK_DIR="jdk1.8.0_202"
ENV JDK_MD5="0029351f7a946f6c05b582100c7d45b7"
ENV BASE_DIR="/java-tron"
ENV SRC_DIR="https://github.com/tronprotocol/java-tron.git"

RUN set -o errexit -o nounset \
    && yum -y install git wget \
    && wget -P /usr/local https://github.com/frekele/oracle-java/releases/download/8u202-b08/$JDK_TAR \
    && echo "$JDK_MD5 /usr/local/$JDK_TAR" | md5sum -c \
    && tar -zxf /usr/local/$JDK_TAR -C /usr/local\
    && rm /usr/local/$JDK_TAR

ENV TAG="GreatVoyage-v4.7.0.1"

RUN    export JAVA_HOME=/usr/local/$JDK_DIR \
    && export CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar \
    && export PATH=$PATH:$JAVA_HOME/bin \
    && mkdir -p $TMP_DIR && cd $TMP_DIR \
    && git clone -c advice.detachedHead=false -b $TAG $SRC_DIR && cd java-tron \
    && ./gradlew build -x test \
    && cd build/distributions && ls -la \
    && 7za x -y java-tron-1.0.0.zip  \
    && mv java-tron-1.0.0 $BASE_DIR \
    && rm -rf $TMP_DIR \
    && rm -rf ~/.gradle \
    && mv $JAVA_HOME/jre /usr/local \
    && rm -rf $JAVA_HOME \
    && yum clean all

RUN wget -P $BASE_DIR/config https://raw.githubusercontent.com/tronprotocol/tron-deployment/master/main_net_config.conf

ENV JAVA_HOME="/usr/local/jre"
ENV PATH=$PATH:$JAVA_HOME/bin

COPY docker-entrypoint.sh $BASE_DIR/bin/docker-entrypoint.sh

WORKDIR $BASE_DIR

ENTRYPOINT ["./bin/docker-entrypoint.sh"]
