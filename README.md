# 利用Ansible部署kubernetes集群

本文档记录自己实践部署高可用k8s集群的过程，利用ansible-playbook简化二进制方式部署过程。

网上有很多类似shell脚本和ansible部署版本，要不看得太复杂，或者久未更新，所以这里自己造轮子吧。

二进制方式手动部署，将有助于理解系统各组件的交互原理和熟悉组建启动参数，进而能快速解决实际问题。

1. 建议阅读 [feisky.gitbooks](https://feisky.gitbooks.io/kubernetes/) 原理和部署章节。
1. 建议阅读 [opsnull教程](https://github.com/opsnull/follow-me-install-kubernetes-cluster) 二进制手工部署。

本文是按照上述文档，更新组件实践修饰而成。

## 特性

1. 截至2017-8-24 最新组件版本，参见[down版本](./down/download.sh) 文件。
1. 因本人部署节点IP属于同一网段，使用flannel新后端[host-gw](https://github.com/coreos/flannel/blob/master/Documentation/backends.md) 提升部分性能。

## 步骤

1. 准备4台虚机(物理机也可，虚机实验更方便)，安装Ubuntu16.04(centos7理论上一样，不想ansible脚本太多条件判断)
1. 准备一台部署机(可以复用上述4台虚机)，安装ansible，配置到4台目标机器ssh无密码登陆等
1. 准备外部负载均衡，准备master节点的vip地址
1. 规划集群节点，完成ansible inventory文件[参考](hosts)

### 安装操作系统
准备4台虚机(物理机也可，虚机实验更方便)，安装Ubuntu16.04
### 准备一台部署机(可以复用上述4台虚机)，安装ansible，配置到4台目标机器ssh无密码登陆等
``` bash
apt install python-pip
pip install pip --upgrade
pip install ansible
ssh-keygen -t rsa -b 2048
ssh-copy-id Server_IP

``` 
