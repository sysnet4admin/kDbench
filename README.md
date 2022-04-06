# `kDbench`: Kubernetes Stroage Performance Test
[![version](https://img.shields.io/badge/version-1.0.0-yellow.svg)](https://semver.org)
![Proudly written in Bash](https://img.shields.io/badge/written%20in-bash-ff69b4.svg)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
</br>dbench source image from [leeliu/dbench](https://github.com/leeliu/dbench)

## **`kDbench`** DEMO 
![kdbench-demo GIF](img/kdbench-demo.gif)

-----
## Requirement 
k8s's API >= `1.21.x` or feature gate `ttlSecondsAfterFinished` is enable
```bash
[root@m-k8s ~]# kubectl get nodes
NAME     STATUS   ROLES                  AGE   VERSION
m-k8s    Ready    control-plane,master   54d   v1.23.1
w1-k8s   Ready    <none>                 54d   v1.23.1
w2-k8s   Ready    <none>                 54d   v1.23.1
w3-k8s   Ready    <none>                 54d   v1.23.1
```
Less than kubernetes version in `1.21.x`, it won't be work properly due to the `ttlSecondsAfterFinished` feature cannot enable as a default on Managed k8s(eks,aks,gke)</br>
Thus in case of self-hostsed or others should turn on `ttlSecondsAfterFinished` 

## Purpose 
Simple and automatically benchmark for your k8s storageclasses.</br> 
(i.e. for lazy engineer who like me) 

-----
## Usage
Highly recommanedation to install [`fzf`](https://github.com/junegunn/fzf) before you run. </br>
[`fzf`](https://github.com/junegunn/fzf) could support **interactively** select a storageclass.

### Interactive mode 
```bash
$ kdbench 
# select one of them 
efs-sc 
gp2

# run automatically 
persistentvolumeclaim/kdbench-pv-claim created
job.batch/kdbench created
Waiting for kdbench's load....Working dir: /ON-efs-sc

Testing Read IOPS...
read_iops: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.29-148-ge3de2
Starting 1 process
read_iops: Laying out IO file (1 file / 2048MiB)
<snipped>
All tests complete for [efs-sc]

=============================
= Kubernetes Dbench Summary =
=============================
Random Read/Write IOPS............................ [24.4k / 7330]
Bandwidth Read/Write.............................. [300MiB/s / 100MiB/s]
Average Latency Read(usec)/Write(usec)............ [2542.07 / 7907.11]
Sequential Read/Write............................. [301MiB/s / 102MiB/s]
Mixed Random Read/Write IOPS...................... [7121 / 2391]
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Waiting for job finished by ttlSecondsAfterFinished...

# delete automatically
kdbench finsihed and pvc will delete
persistentvolumeclaim "kdbench-pv-claim" deleted
```

### Manual mode 
```bash
$ kdbench <storageclass name>
<snipped>
All tests complete for [standard-rwx]

=============================
= Kubernetes Dbench Summary =
=============================
Random Read/Write IOPS............................ [53.3k / 1572]
Bandwidth Read/Write.............................. [942MiB/s / 126MiB/s]
Average Latency Read(usec)/Write(usec)............ [264.60 / 2812.10]
Sequential Read/Write............................. [1228MiB/s / 128MiB/s]
Mixed Random Read/Write IOPS...................... [4674 / 1575]
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Waiting for job finished by ttlSecondsAfterFinished...

# delete automatically 
kdbench finsihed and pvc will delete
persistentvolumeclaim "kdbench-pv-claim" deleted
```

### Other options 

#### Quick mode 
When you choose quick-mode, Only IOPS and Bandwidth will be tested 
```bash
$ kdbench -q 
```
_OR_
```bash
$ kdbench --quick 
```

#### Direct fio write 
If value is true, use non-buffered I/O. This is usually O_DIRECT. Note that OpenBSD and ZFS on Solaris don’t support direct I/O. On Windows the synchronous ioengines don’t support direct I/O. Default: false.
https://fio.readthedocs.io/en/latest/fio_doc.html
```bash
$ kdbench -d 
```
_OR_
```bash
$ kdbench --direct 
```

#### From fio file 
`[TBD]`

#### Reset  
When abnormal behavior has been occurred, please run `reset` and then rerun kdbench command.  
```bash
$ kdbench reset
```
-----
## Install kDbench 

### Using git
```bash 
git clone --depth 1 https://github.com/sysnet4admin/kdbench.git  ~/.kdbench
~/.kdbench/install
```

-----
## Uninstall kDbench 

```bash
~/.kdbench/uninstall
```
