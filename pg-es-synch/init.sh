# create indices with mappings
#curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/users -d @es-mappings/users.json
#curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/user_address -d @es-mappings/user_address.json
#curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/user_additional_info -d @es-mappings/user_additional_info.json

# setup connectors
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-connectors/users-sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-connectors/user_address-sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-connectors/user_additional_info-sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @es-connectors/pg_user_data-source.json
