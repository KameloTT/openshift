oc apply -f initial_configs/argocd-sub.yaml
oc apply -f initial_configs/infra-ns.yaml -f initial_configs/developer-ns.yaml
oc delete argocd --all -n opesnhift-gitops
oc apply -f initial_configs/infra-argocd-cr.yaml -f initial_configs/developer-argocd-cr.yaml
oc adm groups new OpenshiftAdmin
oc adm groups add-users OpenshiftAdmin admin
oc adm policy add-cluster-role-to-user cluster-admin -z cluster-level-argocd-argocd-application-controller -n cluster-level-argocd
oc adm policy add-cluster-role-to-user cluster-admin -z developer-argocd-argocd-application-controller -n developer-argocd
oc adm policy add-cluster-role-to-user cluster-admin -z default -n team1-dev
oc adm policy add-cluster-role-to-user cluster-admin -z default -n team2-dev


oc adm groups new app-team1
oc adm groups new app-team2
oc adm groups add-users app-team1 user1
oc adm groups add-users app-team2 user2
