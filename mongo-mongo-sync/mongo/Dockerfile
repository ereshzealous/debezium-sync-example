FROM mongo:3.6

COPY load-mongo.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/load-mongo.sh

CMD ["mongod", "--replSet", "rs0", "--auth"]