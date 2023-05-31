# Description 

This project is describe how to integrate Red Hat Serverless, Red Hat ServiceMesh and Red Hat AMQ Streams with Kafka.

# Architecture Diagram:
![alt text1][logo]

[logo]: img/pic1.png "knative+istio_kafka"


# Implementation

1. Preparation.
Make sure that Openshift cluster has following installed operators:
  * Red Hat Integration - AMQ Streams
  * Red Hat OpenShift distributed tracing platform
  * Kiali Operator
  * Red Hat OpenShift Serverless
  * Red Hat OpenShift Service Mesh

2. Create some custom Projects in Openshift cluster( file 0_certs.sh)
  * main-1 (Project for Kafka cluster)
  * app-1  (Project with knative test application)
  * app-2  (Project with client which can send test events to knative application)
  * mesh-external (optionally namespace with imitation of external service)
  * istio-system (Porject for ServiceMesh Control Plane)

Current release of Knative is required to have ServiceMesh Control Plane in istio-system project.
https://docs.openshift.com/container-platform/4.8/serverless/admin_guide/serverless-ossm-setup.html#serverless-ossm-setup_serverless-ossm-setup

3. Create or get custom certificates for mTLS encryption ( file 0_certs.sh)
```
  oc create secret -n istio-system generic client-credential --from-file=tls.key=client.example.com.key   --from-file=tls.crt=client.example.com.crt --from-file=ca.crt=example.com.crt
```

4. Create default ServiceMesh Control Plane and Add members "app-1" and "knative-serving"
```
  oc apply -f 1_istio.yaml 
```

5. Add Knative Gateways(one for local traffic, second for external) to Istio configuration
```
  oc apply -f 2_knative-istio.yaml 
```

6. Deploy Knative-serving, Knative-eventing, KnativeKafka object

:warning: Before deploying Knative make sure that ServiceMesh up and works

```
  oc apply -f 3_knative.yaml 
```

6. Deploy knative application to *app-1* project
```
  oc apply -f 4_knative-app.yaml 
```

7. Deploy Kafka cluster and new topic to *main-1* and KafkaSource to *app-1*
```
  oc apply -f 5_kafka.yaml
```

8. Deploy client(producer) to *app-2* which every 3 seconds will send test message to our knative application(consumer)
```
  oc -n app-2 run kafka-producer --image=strimzi/kafka:0.14.0-kafka-2.3.0 --restart=Never -- bash -c 'while true; do echo {"msg": "This is a test!"} | /opt/kafka/bin/kafka-run-class.sh kafka.tools.ConsoleProducer --broker-list my-cluster-kafka-bootstrap.main-1.svc.cluster.local:9092 --topic knative-demo-topic;sleep 3;done'
```

# Example of traffic flow diagram for Kiali

![alt text2][logo1]

[logo1]: img/pic2.png "kiali"


# Useful Command:

Check all messages in the topic:
```
/opt/kafka/bin/kafka-run-class.sh kafka.admin.ConsumerGroupCommand --bootstrap-server <broker_url>:9092  --describe --all-groups
```

Get the number of messages in a topic
```
/opt/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list <broker_url>:9092 --topic <topic_name>
```

# Useful Links:
1. https://docs.openshift.com/container-platform/4.9/serverless/admin_guide/serverless-ossm-setup.html
2. https://knative.dev/docs/eventing/sources/kafka-source/
3. https://knative.dev/docs/eventing/observability/metrics/eventing-metrics/
4. https://knative.dev/docs/serving/knative-kubernetes-services/#components
5. https://knative.dev/docs/serving/istio-authorization/#before-you-begin
6. https://events.istio.io/istiocon-2021/slides/b7p-PerformanceTuningKnative-GongZhang-YuZhuang.pdf


