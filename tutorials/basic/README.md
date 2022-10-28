# Basic Tutorial

To build the container to test locally:

```bash
$ docker build -t basic .
```

And run the container locally:

```bash
$ docker run -it basic
```

Since we don't have a tutorial interface set up, for now it's a command line.
In your working directory you should have a bin with the rajaperf binary that
you can use to dump metrics.  Do:

```console
 ./bin/raja-perf.exe -k Algorithm_MEMSET -sp
```
To dump the output (.csv and .cali for caliper) files to the present working
directory.

**under development**
