from setuptools import setup


setup(
    name='yabee-kitsunetsuki',
    version='13.0',
    description='Blender .egg exporter',
    long_description='Export models from the Blender to Panda3D game engine',
    url='https://github.com/09th/YABEE',
    download_url='https://github.com/09th/YABEE',
    author='09th',
    license='MIT',
    packages=(
        'yabee_libs',
        'yabee_kitsunetsuki',
    ),
    entry_points={
        'console_scripts': (
            'yabee_kitsunetsuki=yabee_kitsunetsuki:main',
        ),
    },
)
