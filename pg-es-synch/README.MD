
#  Change Data Capture from POSTGRES to Elastic Search Using Debezium

  A docker compose is used to set up the infrastructure needed for the demo:
  * Postgres
  * Kafka
	  * Zookeeper.
	  * Kafka Broker. 
	  * Kafka Connect with [Debezium](https://debezium.io/) and  [Elasticsearch](https://github.com/confluentinc/kafka-connect-elasticsearch) Connectors.
	  * kafdrop For UI to Kafka topics.
* ElK Stack
	* Elastic Search.
	* Kibana.

## Usage
``` shell
export DEBEZIUM_VERSION=1.4 or latest

# Build the docker file using docker compose. It will take a while for first time.
docker-compose up --build

# Configure the connectors. For simplicity I created shell script. 
./init.sh
```
