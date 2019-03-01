import platform
import os

from urllib.request import urlretrieve


arch, _ = platform.architecture()
barch = '32' if arch == '32bit' else '64'
boost = '1.65.1'
boost_ = boost.replace('.', '_')
vc = '14.1'
print('architecture: {}'.format(arch))
print('boost version: {}'.format(boost))
print('vc version: {}'.format(vc))

fname = 'boost_{boostu}-msvc-{vc}-{arch}.exe'.format(**{
    'boostu': boost_,
    'vc': vc,
    'arch': barch,
})
# cdn = 'https://excellmedia.dl.sourceforge.net/project/boost/boost-binaries/'
cdn = 'https://datapacket.dl.sourceforge.net/project/boost/boost-binaries/'
url = '{cdn}/{boost}/{fname}'.format(**{
    'cdn': cdn,
    'boost': boost,
    'fname': fname,
})

fpath = os.path.join(os.getenv('HOME'), fname)
if not os.path.exists(fpath):
    print('downloading {}'.format(url))
    urlretrieve(url, filename=fpath)
