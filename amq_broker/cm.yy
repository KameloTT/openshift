apiVersion: v1
data:
  admin.enabled: "true"
  application.instanceLabelKey: ""
  configManagementPlugins: ""
  dex.config: |
    connectors:
    - config:
        clientID: system:serviceaccount:openshift-gitops:openshift-gitops-argocd-dex-server
        clientSecret: eyJhbGciOiJSUzI1NiIsImtpZCI6Ii1kV0VHa2pwNlR6alo1cmhuWWRNTHlfUkFuWW5SU3N6MlFQYUs0bzlEMG8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvcGVuc2hpZnQtZ2l0b3BzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6Im9wZW5zaGlmdC1naXRvcHMtYXJnb2NkLWRleC1zZXJ2ZXItdG9rZW4tcHpnejgiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoib3BlbnNoaWZ0LWdpdG9wcy1hcmdvY2QtZGV4LXNlcnZlciIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjFmODc2N2NiLWE3NWMtNDhkNS1hZGQzLWFiZmRmNGUxNzdhYyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpvcGVuc2hpZnQtZ2l0b3BzOm9wZW5zaGlmdC1naXRvcHMtYXJnb2NkLWRleC1zZXJ2ZXIifQ.HQ0wvP8OKDDwWW6N9R7zHE3h_KwJLjxnKxM6egupqws9n0IawSeQ2hdrOu058EzvFfnwIEm8GZ4q-B-t9BKdyNCvDFeLgLjUAZJiwW88Is_PWXWYUASFcc09eg3w1bhD6cCmsVdfWFcVm9Sh2gKV2FNA2VQF5aA7AVkRCoel22DUi9bkk6PXL4y_m5wBDCEUlbO-CNvMnnrlL8xDCt2k12WdpJzciFFXjZ6djmEiRaCTQIGGNa7hzVPN4GjBrZX69ibSJQJqZHMGz0pBuasWgsifS2OBLxHeYg5ZprmsxJsg-1_n8QsqETFKGFx0yAA61Tx9FbjQqPThcuWR7-a5vpcoxt5FTYG-jH7GGVmryxJUe1epgGvhwrFZKtfAClh3SB9ZEQ4dNVoG3Yd58qxsEZ6wqW57RkQElnakRYJUinENACkMWtKAMx0MPh47uXC3kLfk0M9iTyq2tTzbpke8XcxkZ866SbyvWPrUu5pO3DSUACCl1MZVEd7wij6SxmqohjpSyoeN4Nz539SGyJMWMum8BysQPgF4848fNEYNcGrmXEiotqB7Ic27GNPOSMgUxrkgTd2Er4Diy8HmcVg-Zx6_xNYRR8BdIH8c85u72D4VIT54uBIt3NUDSaP2eD12XELhAoB2o0qdkE9m0sfcOqqJpHWzpB_aVhzhAVmongM
        groups: []
        insecureCA: true
        issuer: https://kubernetes.default.svc
        redirectURI: https://openshift-gitops-server-openshift-gitops.apps.ocpvish.sandbox1615.opentlc.com/api/dex/callback
      id: openshift
      name: OpenShift
      type: openshift
  ga.anonymizeusers: "false"
  ga.trackingid: ""
  help.chatText: ""
  help.chatUrl: ""
  kustomize.buildOptions: ""
  repositories: ""
  repository.credentials: ""
  resource.customizations.health.argoproj.io_Application: |
    hs = {}
    hs.status = "Progressing"
    hs.message = ""
    if obj.status ~= nil then
      if obj.status.health ~= nil then
        hs.status = obj.status.health.status
        if obj.status.health.message ~= nil then
          hs.message = obj.status.health.message
        end
      end
    end
    return hs
  resource.exclusions: |
    - apiGroups:
      - tekton.dev
      clusters:
      - '*'
      kinds:
      - TaskRun
      - PipelineRun
  resource.inclusions: ""
  statusbadge.enabled: "false"
  url: https://openshift-gitops-server-openshift-gitops.apps.ocpvish.sandbox1615.opentlc.com
  users.anonymous.enabled: "false"
kind: ConfigMap
metadata:
  creationTimestamp: "2022-06-01T14:03:00Z"
  labels:
    app.kubernetes.io/managed-by: openshift-gitops
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
  namespace: openshift-gitops
  ownerReferences:
  - apiVersion: argoproj.io/v1alpha1
    blockOwnerDeletion: true
    controller: true
    kind: ArgoCD
    name: openshift-gitops
    uid: d7a382b5-cd59-44be-bcdf-268b52dbc8a8
  resourceVersion: "1792201"
  uid: adf670a2-ff3c-4bfa-b749-ebdf22b4c146
