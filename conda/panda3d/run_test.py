import os
import zipfile

import panda3d.core
import panda3d.bullet
import panda3d.direct
import panda3d.egg
import panda3d.fx
import panda3d.physics
import panda3d.skel

from panda3d.core import load_prc_file_data, VirtualFileSystem, Filename


if os.path.exists('test.txt'):
    os.remove('test.txt')

with open('test.txt', 'w') as f:
    f.write('test')

if os.path.exists('test.zip'):
    os.remove('test.zip')

with zipfile.ZipFile(
        'test.zip', mode='x',
        compression=zipfile.ZIP_DEFLATED) as f:
    f.write('test.txt')

vfs = VirtualFileSystem.get_global_ptr()
assert vfs.mount('test.zip', '', 0) is True

load_prc_file_data('', '''
audio-library-name null
window-type none
model-path .
''')

from direct.showbase.ShowBase import ShowBase

base = ShowBase()
wfont = os.path.join(os.getenv('RECIPE_DIR'), 'Ubuntu-R.ttf')
ufont = Filename.from_os_specific(wfont).get_fullpath()
base.loader.load_font(ufont)
