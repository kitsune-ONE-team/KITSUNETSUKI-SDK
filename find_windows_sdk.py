import os
import sys

kits_dir = 'C:\\Program Files (x86)\\Windows Kits\\10\\Bin'
sdk_arch = 'x64'

versions = []
for version in os.listdir(kits_dir):
    if not version.split('.')[0].isdigit():
        continue

    versions.append(version)


def sort(item):
    return tuple(map(int, item.split('.')))


for version in reversed(sorted(versions, key=sort)):
    sdk_path = os.path.join(kits_dir, version, sdk_arch)

    if os.path.exists(os.path.join(sdk_path, 'rc.exe')):
        if sys.argv[-1] == 'path':
            print(sdk_path)
            break
        elif sys.argv[-1] == 'version':
            print(version)
            break