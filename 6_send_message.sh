oc -n app-2 run kafka-producer --image=strimzi/kafka:0.14.0-kafka-2.3.0 --restart=Never -- bash -c 'while true; do echo {"msg": "This is a test!"} | /opt/kafka/bin/kafka-run-class.sh kafka.tools.ConsoleProducer --broker-list my-cluster-kafka-bootstrap.main-1.svc.cluster.local:9092 --topic knative-demo-topic;sleep 3;done'