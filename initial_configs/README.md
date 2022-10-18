oc apply -f ns.yaml
oc delete argocd --all -n opesnhift-gitops

oc apply -f argocd-cr.yaml
oc adm groups new OpenshiftAdmin
oc adm groups add-users OpenshiftAdmin admin
oc adm policy add-cluster-role-to-user cluster-admin -z cluster-level-argocd-argocd-application-controller -n cluster-level-argocd
oc adm policy add-cluster-role-to-user cluster-admin -z cluster-level-argocd-argocd-server -n cluster-level-argocd
oc adm groups new app-team1
oc adm groups new app-team2
oc adm groups add-users app-team1 user1
oc adm groups add-users app-team2 user2
