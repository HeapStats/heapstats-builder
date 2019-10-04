# Build bot on Kubernetes

You can use Kubernete Job for building HeapStats.  
I've tested the job on [Minikube](https://github.com/kubernetes/minikube) and [k3OS](https://k3os.io/).

## Configure environment variables

You need to configure environment variables in [build-config.yaml](build-config.yaml).

## Configure the volume for output

This build bot depends on persistent volume claim in [pv-claim.yaml](pv-claim.yaml). So you need to assign PV which has `heapstats` in `storageClassName`.  
This build bot has [host-pv.yaml](host-pv.yaml). It defines persistent volume for `/tmp/share` in the node. If you want to use it, please run `kubectl create -f host-pv.yaml`.

## Build HeapStats binaries on Kubernetes

```
$ kubectl create -f pv-claim.yaml
$ kubectl create -f build-config.yaml
$ kubectl create -f build.yaml
```

### Run on the job on Minikube

Please see [Minikube README](https://github.com/kubernetes/minikube/blob/master/README.md).  
If you run Minikube with `--vm-driver=none`, you might need to pass `--extra-config=kubelet.CgroupDriver=systemd` to argument.
