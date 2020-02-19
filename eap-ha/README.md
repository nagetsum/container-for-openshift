eap-ha based on zip distributaion EAP
========================================

Steps to deploy:
```
oc new-build --binary --name=echo -l app=echo
oc start-build echo --from-dir=. --follow
oc create -f echo-ping.yaml
oc new-app --image-stream=echo
```
