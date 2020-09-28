#### Autoit-docker

This image contains a fairly generic wine installation and can be used as such.
It also includes an installation of autoit (https://www.autoitscript.com) and so enables processing autoit scripts via wine, but does not require a local x11 host to work.

check the Dockerfile for details.

Usage:

the container /autoit/ directory contains the cmdline accessible autoit executable aut2exe.exe.

assuming a local folder on a windows box called C:\somefolder\otherfolder containing your script and resources

```
docker run --rm -v C:\somefolder\otherfolder:/work  datamine/autoit:latest wine /autoit/aut2exe.exe /in /work/some_autoit_script.au3 /out /work/target/out.exe /x64 
```

on linux hosts you can sync the current host and container users so that the output is written as the same userid by also passing.

```
-e uid=$(id -u)
```

