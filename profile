export JAVA_HOME=/usr/local/openjdk7
export PATH=${PATH}:${JAVA_HOME}/bin
export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
#export LD_LIBRARY_PATH=.:..:$LD_LIBRARY_PATH:snappy-java-1.0.4.1.jar

#Hadoop
export HADOOP_VERSION=1.0.3
export HADOOP_HOME_WARN_SUPPRESS=1
export HADOOP_HOME=/usr/local/application/user-app/hadoop-${HADOOP_VERSION}
export HADOOP_CONF_DIR=/usr/local/application/user-conf/hadoop-${HADOOP_VERSION}
export HADOOP_LOG_DIR=/usr/local/application/user-data/hadoop-${HADOOP_VERSION}/log
export PATH=${PATH}:${HADOOP_HOME}/bin

#Cassandra
export CASSANDRA_HOME=/usr/local/application/user-app/cassandra-1.1.1
export CASSANDRA_CONF=/usr/local/application/user-conf/cassandra-1.1.1
export PATH=${PATH}:${CASSANDRA_HOME}/bin
export CLASSPATH=${CLASSPATH}:${CASSANDRA_HOME}/lib

#zookeeper
export ZOOKEEPER_HOME=/usr/local/application/user-app/zookeeper-3.4.3
export PATH=${PATH}:${ZOOKEEPER_HOME}/bin

#mahout
export MAHOUT_HOME=/usr/local/application/user-app/mahout-0.6

export PATH=${PATH}:${MAHOUT_HOME}/bin

#Hbase
export HBASE_HOME=/usr/local/application/user-app/hbase-0.92.1
export PATH=${PATH}:${HBASE_HOME}/bin