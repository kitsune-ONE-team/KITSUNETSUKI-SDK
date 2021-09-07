import os
import sys

KIT = 'C:\\Program Files (x86)\\Windows Kits\\10\\Bin'

versions = []
for i in os.listdir(KIT):
    v = i.split('.')
    if os.path.isdir(i) and v[0].isdigit():
        versions.append(tuple(map(int, v)))


for i in reversed(sorted(versions)):
    sdk_version = '.'.join(map(str, i))
    sdk_path = os.path.join(KIT, sdk_version, 'x64')
    if os.path.exists(os.path.join(sdk_path, 'rc.exe')):
        if sys.argv[-1] == 'path':
            print(sdk_path)
        elif sys.argv[-1] == 'version':
            print(sdk_version)
