KITSUNETSUKI SDK
================




Jenkins Linux Agent configuration
---------------------------------

**Remote root directory:** /app/jenkins

**Labels:** linux

**SSH Host:** agent


Jenkins Windows Agent configuration
-----------------------------------

**Remote root directory:** C:\jenkins

**Labels:** windows

**SSH Host:** _VM's host_

**JavaPath:** Z:\jdk-21\bin\java

(Java could be downloaded from [https://jdk.java.net/java-se-ri/21])

**Prefix Start Agent Command:** "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" amd64 10.0.22000.0 &&

**Environment variables:** CL=/MP
