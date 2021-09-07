import os
import sys

KIT = 'C:\\Program Files (x86)\\Windows Kits\\10\\Bin'

sdk_arch = 'x64' if os.getenv('ARCH') else 'x86'

versions = []
for version in os.listdir(KIT):
    parts = version.split('.')
    if os.path.isdir(os.path.join(KIT, version)) and parts[0].isdigit():
        versions.append(version)


def sort(item):
    return tuple(map(int, item.split('.')))


for version in reversed(sorted(versions, key=sort)):
    sdk_path = os.path.join(KIT, version, sdk_arch)

    if os.path.exists(os.path.join(sdk_path, 'rc.exe')):
        if sys.argv[-1] == 'path':
            print(sdk_path)
        elif sys.argv[-1] == 'version':
            print(version)
