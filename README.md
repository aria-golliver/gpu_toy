tested only on Windows, but should be nearly cross platform? I've got it building in a docker image (see the Dockerfile) but I haven't actually _used_ it

```shell
mkdir build
cd build
cmake ..
cmake --build .

<exe path> $gpu_toy_root/examples/4d_explorer```