import os
import sys

from PIL import Image


def make_icon_h(src, dest):
    im = Image.open(src)
    with open(dest, 'w') as fp:
        var_name = os.path.basename(dest)
        if var_name.endswith('.h'):
            var_name = var_name[:-2]

        fp.write("static unsigned long %s_prop [] = {\n" % var_name)
        fp.write(" %d, %d\n" % im.size)

        i = 0
        for pixel in im.getdata():
            r, g, b, a = pixel
            pixel = b
            pixel |= g << 8
            pixel |= r << 16
            pixel |= a << 24
            fp.write(" , %du" % pixel)

            i += 1
            if i % 8 == 0:
                fp.write("\n")

        fp.write("};\n")


if __name__ == '__main__':
    make_icon_h(sys.argv[1], sys.argv[2])
