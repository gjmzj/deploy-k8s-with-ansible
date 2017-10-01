#!/bin/bash
#主要组件版本如下
export K8S_VER=v1.7.6
export ETCD_VER=v3.2.6
export FLANNEL_VER=v0.8.0
export DOCKER_VER=17.09.0-ce

echo "\n----download k8s binary at:"
echo https://dl.k8s.io/${K8S_VER}/kubernetes-server-linux-amd64.tar.gz

echo "\n----download etcd binary at:"
echo https://github.com/coreos/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz
echo https://storage.googleapis.com/etcd/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz

echo "\n----download flannel binary at:"
echo https://github.com/coreos/flannel/releases/download/${FLANNEL_VER}/flannel-${FLANNEL_VER}-linux-amd64.tar.gz

echo "\n----download docker binary at:"
echo https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VER}.tgz

echo "\n----download ca tools at:"
echo https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
echo https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
echo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64

echo "\n注意1：因为网络原因不进行自动下载，否则脚本执行不可控制"
echo "请按照以上链接手动下载二进制包到down目录中，包含如下："
echo "-rw-r--r-- 1 root root   6595195 Mar 30  2016 cfssl-certinfo_linux-amd64"
echo "-rw-r--r-- 1 root root   2277873 Mar 30  2016 cfssljson_linux-amd64"
echo "-rw-r--r-- 1 root root  10376657 Mar 30  2016 cfssl_linux-amd64"
echo "-rwxr--r-- 1 root root  29699281 Aug 24 17:09 docker-17.06.1-ce.tgz*"
echo "-rwxr--r-- 1 root root  10176124 Aug 24 17:09 etcd-v3.2.6-linux-amd64.tar.gz*"
echo "-rwxr--r-- 1 root root   9090192 Aug 24 17:09 flannel-v0.8.0-linux-amd64.tar.gz*"
echo "-rwxr--r-- 1 root root 437406487 Aug 24 17:09 kubernetes-server-linux-amd64.tar.gz*"

echo "\n注意2：如果还没有手工下载tar包，请Ctrl-c结束此脚本\nsleep 60"
sleep 60

mkdir -p ../bin
mv cfssl_linux-amd64 ../bin/cfssl
mv cfssljson_linux-amd64 ../bin/cfssljson
mv cfssl-certinfo_linux-amd64 ../bin/cfssl-certinfo

echo "\nextracting etcd binaries..."
tar zxf etcd-${ETCD_VER}-linux-amd64.tar.gz
mv etcd-${ETCD_VER}-linux-amd64/etcd* ../bin

echo "\nextracting flannel binaries..."
tar zxf flannel-${FLANNEL_VER}-linux-amd64.tar.gz
mv flanneld mk-docker-opts.sh ../bin
rm README.md

echo "\nextracting kubernetes binaries..."
tar zxf kubernetes-server-linux-amd64.tar.gz
mv kubernetes/server/bin/kube-apiserver ../bin
mv kubernetes/server/bin/kube-controller-manager ../bin
mv kubernetes/server/bin/kubectl ../bin
mv kubernetes/server/bin/kubelet ../bin
mv kubernetes/server/bin/kube-proxy ../bin
mv kubernetes/server/bin/kube-scheduler ../bin

echo "\nextracting docker binaries..."
tar zxf docker-${DOCKER_VER}.tgz
mv docker/docker* ../bin
if [ -f "docker/completion/bash/docker" ]; then
  mv -f docker/completion/bash/docker ../roles/kube-node/files/docker
fi
