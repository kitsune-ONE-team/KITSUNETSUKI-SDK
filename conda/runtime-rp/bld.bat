mkdir %PREFIX%\python
mkdir %PREFIX%\python\Lib
mkdir %PREFIX%\python\Lib\site-packages

xcopy /I /E /Y %CONDA_PREFIX%\Lib\site-packages\rpcore ^
    %PREFIX%\python\Lib\site-packages\rpcore
xcopy /I /E /Y %CONDA_PREFIX%\Lib\site-packages\rplibs ^
    %PREFIX%\python\Lib\site-packages\rplibs
xcopy /I /E /Y %CONDA_PREFIX%\Lib\site-packages\rpplugins ^
    %PREFIX%\python\Lib\site-packages\rpplugins
xcopy /I /E /Y %CONDA_PREFIX%\Lib\site-packages\data ^
    %PREFIX%\python\Lib\site-packages\data
xcopy /I /E /Y %CONDA_PREFIX%\Lib\site-packages\effects ^
    %PREFIX%\python\Lib\site-packages\effects

del /F /S /Q %PREFIX%\python\Lib\site-packages\data\builtin_models\skybox\skybox-blend.zip
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\builtin_models\skybox\skybox.jpg
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\builtin_models\skybox\skybox-2.jpg
rmdir /S /Q %PREFIX%\python\Lib\site-packages\data\default_cubemap
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\generate_txo_files.py
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\environment_brdf\generate_reference.py
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\environment_brdf\run_mitsuba.bat
rmdir /S /Q %PREFIX%\python\Lib\site-packages\data\environment_brdf\res
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\film_grain\generate.py
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\film_grain\grain.compute.glsl
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\ies_profiles\PREVIEWS.jpg
del /F /S /Q %PREFIX%\python\Lib\site-packages\data\gui\loading_screen_bg.png

del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\bloom\resources\SOURCE.txt
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\bloom\resources\lens_dirt.png
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\clouds\resources\generate_noise1.compute.glsl
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\clouds\resources\generate_noise2.compute.glsl
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\clouds\resources\noise.inc
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\clouds\resources\precompute.py
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\film_luts\agfa_*
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\film_luts\fujifilm_*
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\film_luts\kodak_*
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\film_luts_raw
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\generate_default_lut.py
del /F /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\color_correction\resources\generate_film_luts.py
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\plugin_prefab
rmdir /S /Q %PREFIX%\python\Lib\site-packages\rpplugins\scattering\resources\hosek_wilkie_scattering
