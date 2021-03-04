import panda3d.core
import panda3d.bullet
import panda3d.direct
import panda3d.egg
import panda3d.fx
import panda3d.physics
import panda3d.skel

from panda3d.core import VirtualFileSystem


import zipfile


with open('test.txt', 'w') as f:
    f.write('test')


with zipfile.ZipFile(
        'test.zip', mode='x',
        compression=zipfile.ZIP_DEFLATED) as f:
    f.write('test.txt')


vfs = VirtualFileSystem.get_global_ptr()
assert vfs.mount('test.zip', '', 0) is True
