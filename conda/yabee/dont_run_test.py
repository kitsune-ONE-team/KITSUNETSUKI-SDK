import sys

from yabee_libs import egg_writer


egg_writer.write_out(**{
    'fname': 'test.egg',
    'anims': {},
    'from_actions': False,
    'uv_img_as_tex': False,
    'sep_anim': False,
    'a_only': False,
    'copy_tex': False,
    't_path': './abyss',
    'tbs': None,
    'tex_processor': 'RAW',
    'b_layers': None,
    'm_actor': True,
    'apply_m': True,
    'pview': False,
    'loop_normals': False,
    'export_pbs': True,
    'force_export_vertex_colors': False,
    'objects': None
})

sys.exit(0)
