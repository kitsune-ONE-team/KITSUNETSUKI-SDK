import os
import zipfile

import panda3d.core
import panda3d.bullet
import panda3d.direct
import panda3d.egg
import panda3d.fx
import panda3d.physics

from panda3d.core import load_prc_file_data, VirtualFileSystem, Filename


# test freetype

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
