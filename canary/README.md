# Canary Deployment Workflow

This project is contains tekton pipeline with autmation of canary deployment.

Decision of traffic promotion is based on "responce code 200" metric from new version of application pods(green).

The pipeline is contains 5 main tasks:

1. "generate-vs" the task generate Istio Virtual Service object with 100% blue traffic and 0% to Green deployment
2. "canary-25perc" the task route of 25% traffic to green deployment
3. "canary-50perc" the task is verify that grren deployment pods has positive code responces(code: 200) and rebalance traffic 50/50 between blue and grren deploeyments
4. "canary-70perc" the task is verify that grren deployment pods has positive code responces(code: 200) with 50% traffic allocation and promote traffic flow to 75% to Green deployment
5. "canary-100perc" the task is verify that grren deployment pods has positive code responces(code: 200) with 50% traffic allocation and completely route all traffic to green deployment.
6. optional("rollback-canary") in case of tekton failure ot absent positive value of responce code tekton will run this task to restore default traffic allocation between deployments and set 100% traffic back to blue deployment.


# Architecture Diagram of the solution

![alt text1][logo2]

[logo2]: canary-deployment.png "canary"

