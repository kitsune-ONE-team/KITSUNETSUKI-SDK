import argparse
import bpy

from yabee_libs import egg_writer


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--input', type=str, required=True, help='Input file')
    parser.add_argument(
        '--output', type=str, required=True, help='Output file')
    parser.add_argument(
        '--tbs', type=str, help='Calculate tangent and bitangent '
        '(binormal): PANDA/BLENDER')
    parser.add_argument(
        '--anim', type=str, help='Animation (action) name to export')
    parser.add_argument(
        '--anim_from', type=int, help='Animation start frame')
    parser.add_argument(
        '--anim_to', type=int, help='Animation end frame')
    parser.add_argument(
        '--anim_fps', type=int, help='Animation frames per second')
    return parser.parse_args()


def main():
    args = parse_args()

    bpy.ops.wm.open_mainfile(filepath=args.input)

    anims = {}
    if args.anim:
        anims[args.anim] = [None] * 3
        if args.anim_from:
            anims[args.anim][0] = args.anim_from
        if args.anim_to:
            anims[args.anim][1] = args.anim_to
        if args.anim_fps:
            anims[args.anim][2] = args.anim_fps

    egg_writer.write_out(**{
        'fname': args.output,
        'anims': anims,
        'from_actions': True,  # export multiple animation from dope sheet
        'uv_img_as_tex': False,
        'sep_anim': False,  # separate animation file
        'a_only': bool(anims),  # animations only
        'copy_tex': False,  # copy textures
        't_path': './abyss',  # copied textures path
        'tbs': args.tbs,  # calc tbs
        'tex_processor': 'RAW',
        'b_layers': None,  # bake layers
        'm_actor': True,  # actor mesh
        'apply_m': True,  # apply modifiers
        'pview': False,
        'loop_normals': False,
        'export_pbs': True,  # export material?
        'force_export_vertex_colors': False,
        'objects': None
    })


if __name__ == '__main__':
    main()
