Logstash - OSS Only for OpenShift
====================================

## How to deploy this image to OpenShift

Download logstash-oss-7.4.1.tar.gz and put into `binary` directory in this repository.

```
oc new-project logstash
oc new-build --name logstash --binary --strategy docker
oc start-build logstash --from-dir=.
oc new-app --image-stream=logstash
```


## Reference

OpenShift Container Platform-Specific Guidelines
https://docs.openshift.com/container-platform/3.11/creating_images/guidelines.html#openshift-specific-guidelines

Starter-arbitrary-uid RHEL-based Image w/ best practices
https://github.com/RHsyseng/container-rhel-examples/tree/master/starter-arbitrary-uid

