import json
import os
import ssl
import zipfile

from urllib.request import urlopen, urlretrieve


def main():
    # ssl._create_default_https_context = ssl._create_unverified_context

    url = 'https://kitsune.one/k/api/release/'
    data = json.loads(urlopen(url).read().decode('utf-8'))

    for i in data:
        if i['key'] == 'release.kitsune_one.url' and i['platform'] == 'winx64':
            filename = os.path.basename(i['value'])
            if not os.path.exists(filename):
                urlretrieve(i['value'], filename=filename)

                dirname = 'kitsunetsuki'
                if not os.path.exists(dirname):
                    os.makedirs(dirname)
                    with zipfile.ZipFile(filename, mode='r') as z:
                        z.extractall(dirname)


if __name__ == '__main__':
    main()
