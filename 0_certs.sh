openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example.com.key -out example.com.crt
openssl req -out client.example.com.csr -newkey rsa:2048 -nodes -keyout client.example.com.key -subj "/CN=client.example.com/O=client organization"
openssl x509 -req -sha256 -days 365 -CA example.com.crt -CAkey example.com.key -set_serial 1 -in client.example.com.csr -out client.example.com.crt

oc new-project istio-system
oc create secret -n istio-system generic client-credential --from-file=tls.key=client.example.com.key   --from-file=tls.crt=client.example.com.crt --from-file=ca.crt=example.com.crt
oc new-project app-1
oc new-project app-2
oc new-project mesh-external
oc create -n mesh-external secret generic nginx-ca-certs --from-file=example.com.crt
