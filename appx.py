import json
import os
import zipfile
import ssl

from urllib.request import urlopen, urlretrieve


def main():
    ssl._create_default_https_context = ssl._create_unverified_context

    url = 'https://kitsune.one/k/api/release/'
    data = json.loads(urlopen(url).read().decode('utf-8'))

    for i in data:
        if i['key'] == 'release.kitsune_one.url' and i['platform'] == 'winx64':
            filename = os.path.basename(i['value'])
            urlretrieve(i['value'], filename=filename)
            os.makedirs('kitsunetsuki')
            with zipfile.ZipFile(filename, mode='r') as z:
                z.extractall('kitsunetsuki')


if __name__ == '__main__':
    main()
