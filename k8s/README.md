# Build bot on Kubernetes

You can use Kubernete Job for building HeapStats.  
I've tested the job on [Minikube](https://github.com/kubernetes/minikube).

## Configure environment variables

You need to configure environment variables in [build-config.yaml](build-config.yaml).

## Configure the volume for output

[build.yaml](build.yaml) is configured to use `/tmp/share` to output binaries by default. However `hostPath` is only used in single Kuernetes node.  
So you need to change to other [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) if you want to run the job on Kubernetes cluster.:w

## Build HeapStats binaries on Kubernetes

```
$ kubectl create -f build-config.yaml
$ kubectl create -f build.yaml
```

### Run on the job on Minikube

Please see [Minikube README](https://github.com/kubernetes/minikube/blob/master/README.md).  
If you run Minikube with `--vm-driver=none`, you might need to pass `--extra-config=kubelet.CgroupDriver=systemd` to argument.
