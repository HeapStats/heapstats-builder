Build bot on Kubernetes
===================

You can use Kubernete Job for building HeapStats.  
I've tested the job on [Minikube](https://github.com/kubernetes/minikube) and [k3OS](https://k3os.io/).

# Configure environment variables

You need to configure environment variables in `build-config-2.*.yaml` in [config/](config).

# Configure the volume for output

This build bot depends on persistent volume claim in `pv/pv-claim*.yaml`. So you need to assign PV which has `heapstats` and `heapstats-maven` in `storageClassName`.  
This build bot has `pv/host-pv*.yaml`. They define persistent volume for `/tmp/share` and `/tmp/maven-repo` on the node. If you want to use them, please run `kubectl create -f pv/host-pv*.yaml`.

# Build HeapStats binaries on Kubernetes

## HeapStats 2.1 or earlier

```
$ kubectl create -f pv/pv-claim.yaml
$ kubectl create -f pv/pv-claim-maven.yaml
$ kubectl create -f config/build-config-2.1.yaml
$ kubectl create -f build/build-2.1.yaml
```

## HeapStats 2.2 or later

```
$ kubectl create -f pv/pv-claim.yaml
$ kubectl create -f pv/pv-claim-maven.yaml
$ kubectl create -f config/build-config-2.2.yaml
$ kubectl create -f build/build-2.2.yaml
```

## Run on the job on Minikube

Please see [Minikube README](https://github.com/kubernetes/minikube/blob/master/README.md).  
If you run Minikube with `--vm-driver=none`, you might need to pass `--extra-config=kubelet.CgroupDriver=systemd` to argument.
