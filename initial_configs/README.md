oc apply -f ns.yaml
oc delete argocd --all -n opesnhift-gitops

oc apply -f argocd-cr.yaml
