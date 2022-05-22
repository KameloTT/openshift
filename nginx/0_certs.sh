openssl req -out my-nginx.mesh-external.svc.cluster.local.csr -newkey rsa:2048 -nodes -keyout my-nginx.mesh-external.svc.cluster.local.key -subj "/CN=my-nginx.mesh-external.svc.cluster.local/O=some organization"
openssl x509 -req -sha256 -days 365 -CA ../example.com.crt -CAkey ../example.com.key -set_serial 0 -in my-nginx.mesh-external.svc.cluster.local.csr -out my-nginx.mesh-external.svc.cluster.local.crt
oc create -n mesh-external secret tls nginx-server-certs --key my-nginx.mesh-external.svc.cluster.local.key --cert my-nginx.mesh-external.svc.cluster.local.crt
oc create secret -n app-1 generic client-credential --from-file=tls.key=../client.example.com.key   --from-file=tls.crt=../client.example.com.crt --from-file=ca.crt=../example.com.crt
oc create secret -n app-2 generic client-credential --from-file=tls.key=../client.example.com.key   --from-file=tls.crt=../client.example.com.crt --from-file=ca.crt=../example.com.crt

