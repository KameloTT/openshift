1. Generate GPG key pair based on OpenPGP standard

1.1 Ask name,email and password.
	gpg2 --gen-key
	
1.2 List of keys
	gpg2 --list-keys
	
1.3 Export public key
	gpg --armor --export avishnia@redhat.com > signer-key.pub

1.4 Push simple image to quay.io

	skopeo copy  --dest-authfile quayio.json  docker://quay.io/redhattraining/hello-world-nginx docker://quay.io/avishnia/sign-demo-repo:v1
	
!!!! 1.5 Push signed image to quay.io(this step is required a password)

	skopeo copy --sign-by avishnia@redhat.com --dest-authfile quayio.json  docker://docker.io/luisarizmendi/blog-django-py:1.0 docker://quay.io/avishnia/sign-demo-repo:v1-signed
	
(Starting with Podman version 4.2, you can use the sigstore format of container signatures)
podman push --sign-by-sigstore-private-key ./signer-key.pub --authfile quayio.json docker://quay.io/avishnia/sign-demo-repo:v1-signed
or
podman pull quay.io/redhattraining/hello-world-nginx
podman tag quay.io/redhattraining/hello-world-nginx quay.io/avishnia/sign-demo-repo:v2-signed


	
2. Copy signatures to git repo
	git clone repo
	cp -r /var/lib/containers/sigstore/* repo/images/
	git add -A .;git commit -m "Added signstore";git push
	
3. Create web signing server.
	oc new-project signature-server
	oc new-app httpd~https://github.com/KameloTT/openshift.git#signed-images \
--name signature-server 
	oc expose service/signature-server
	oc scale deployment/signature-server --replicas=2
	
4. Prepare MachineConfig
	policyJSONDAta=`cat policy.json | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;
	defaultYAMLData=`cat default.yaml | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;
	signerKeyPubData=`cat signer-key.pub | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(''.join(sys.stdin.readlines())))"`;
	cat machine-config-template.yaml |sed "s|policy-json-placeholder|$policyJSONDAta|;s|default-yaml-placeholder|$defaultYAMLData|;s|encoded-signer-pub-placeholder|$signerKeyPubData|" > generated-configmap.yaml

5. apply and check
	oc apply -f generated-configmap.yaml
	oc get mcp -w
	
6. run test application
	oc new-app quay.io/redhattraining/hello-world-nginx --name non-signed-app
	oc new-app quay.io/avishnia/sign-demo-repo:v1-signed --name signed-app
