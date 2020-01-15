import json
import os
import shutil
import zipfile

from urllib.request import urlopen, urlretrieve


def main():
    url = 'https://kitsune.one/api/k/release/'
    print('Opening {}'.format(url))
    data = json.loads(urlopen(url).read().decode('utf-8'))

    for i in data:
        if i['key'] == 'release.kitsune_one.url' and i['platform'] == 'winx64':
            filename = os.path.basename(i['value'])
            dirname = 'kitsunetsuki'

            need_wipe = False
            if not os.path.exists(filename):
                need_wipe = True
                print('Downloading {}'.format(i['value']))
                urlretrieve(i['value'], filename=filename)

            if need_wipe:
                shutil.rmtree(dirname)

            if not os.path.exists(dirname):
                os.makedirs(dirname)

            with zipfile.ZipFile(filename, mode='r') as z:
                z.extractall(dirname)


if __name__ == '__main__':
    main()
