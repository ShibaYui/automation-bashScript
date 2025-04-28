```
 ____  _____    _    ____  __  __ _____
|  _ \| ____|  / \  |  _ \|  \/  | ____|
| |_) |  _|   / _ \ | | | | |\/| |  _|
|  _ <| |___ / ___ \| |_| | |  | | |___
|_| \_\_____/_/   \_\____/|_|  |_|_____|
```
> Author: yu1           

> Release_Date: 2025-04-23 05:40:37 +0800

# Name
> NV NCCL

## Ref.
`https://github.com/NVIDIA/nccl`
`https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/index.html`
`https://blog.csdn.net/qq_41185868/article/details/130983787`
`https://github.com/zhaochenyang20/Awesome-ML-SYS-Tutorial/blob/main/distributed/nccl/readme.md`
`https://zhuanlan.zhihu.com/p/25513394133`

## Introduction
NCCL (pronounced "Nickel") is a stand-alone library of standard communication 
routines for GPUs, implementing all-reduce, all-gather, reduce, broadcast, 
reduce-scatter, as well as any send/receive based communication pattern. 
It has been optimized to achieve high bandwidth on platforms using PCIe, 
NVLink, NVswitch, as well as networking using InfiniBand Verbs or TCP/IP sockets. 
NCCL supports an arbitrary number of GPUs installed in a single node or across multiple nodes, 
and can be used in either single- or multi-process (e.g., MPI) applications.

NCCL（發音為「Nickel」）是 GPU 標準通訊例程的獨立函式庫，
可實現全歸約、全聚集、歸約、廣播、歸約散射以及任何基於發送/接收的通訊模式。
它已針對使用 PCIe、NVLink、NVswitch 的平台以及使用 InfiniBand Verbs 或
TCP/IP 套接字的網路實現高頻寬進行了最佳化。 
NCCL 支援在單一節點或多個節點上安裝任意數量的 GPU，並且可以用於單一進程或多進程（例如 MPI）應用程式。

## Syntax
`-b`: minimum size in Bytes
`-e`: maxmum size in Bytes
`-f`: stepFactor（資料大小成長倍數）
`-g`: number of GPUs per process


## Command
> single node
```bash
mpirun --allow-run-as-root -x  NCCL_DEBUG=INFO -host <ip_addr> -np 1 ./all_reduce_perf -b 8 -e 8G -f 2 -g 4
```

> multi node
```bash
mpirun --allow-run-as-root --host <ip_addr1>,<ip_addr2> \
  -np 2 --mca btl_tcp_if_include=enP5p9s0 \
  --mca btl ^openib \
  -x NCCL_SOCKET_IFNAME=enP5p9s0 \
  -x PATH -x LD_LIBRARY_PATH \
  ./all_reduce_perf -b 1M -e 8G -f 2 -g 1
```

> hostfile
多IP（node）的情況下可以node ip_address寫入`hostfile`，格式如下：
aa.aa.aa.aa slot=<要使用MPI Process數>

## Inatallation
> Debian/Ubuntu
```bash
$ # Install tools to create debian packages
$ sudo apt install build-essential devscripts debhelper fakeroot
$ # Build NCCL deb package
$ make pkg.debian.build
$ ls build/pkg/deb/
```

> RedHat/CentOS
```bash
$ # Install tools to create rpm packages
$ sudo yum install rpm-build rpmdevtools
$ # Build NCCL rpm package
$ make pkg.redhat.build
$ ls build/pkg/rpm/
```

> OS-agonstic tarball
```bash
$ make pkg.txz.build
$ ls build/pkg/txz/
```

> Testing
```bash
$ git clone https://github.com/NVIDIA/nccl-tests.git
$ cd nccl-tests
$ make
$ ./build/all_reduce_perf -b 8 -e 256M -f 2 -g <ngpus>
```

## Check Status
> nvtop

Ref.: `https://github.com/Syllo/nvtop`
Installation:
`sudo apt install nvtop`

`sudo add-apt-repository ppa:quentiumyt/nvtop
 sudo apt install nvtop`

## Usage
	Unix-base OS
	PyTorch

## Release
* 2025-04-23 05:40:37 +0800


* 2025-04-26 09:10:09 +0800
	fix syntax issue


