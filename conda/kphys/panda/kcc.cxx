#include "bulletWorld.h"
#include "panda/kcc.h"


static const btVector3 up_vectors[3] = {btVector3(1.0f, 0.0f, 0.0f), btVector3(0.0f, 1.0f, 0.0f), btVector3(0.0f, 0.0f, 1.0f)};

TypeHandle KCCNode::_type_handle;


KCCNode::KCCNode(BulletShape *shape, PN_stdfloat step_height, const char *name):
    BulletCharacterControllerNode(shape, step_height, name) {
    delete _character;

    btConvexShape *convex = (btConvexShape *)(shape->ptr());

    // Bullet KITSUNETSUKI Character Controller
    _character = new btKCC(_ghost, convex, step_height, up_vectors[get_default_up_axis()]);
    _character->setGravity(up_vectors[get_default_up_axis()] * -(btScalar)9.81f);

    _is_synced = true;
}

void KCCNode::do_sync_p2b(PN_stdfloat dt, int num_substeps) {
    if (!_is_synced) return;
    BulletCharacterControllerNode::do_sync_p2b(dt, num_substeps);
}

void KCCNode::do_sync_b2p() {
    if (!_is_synced) return;
    BulletCharacterControllerNode::do_sync_b2p();
}

bool KCCNode::get_synced() {
    return ((btKCC*) _character)->get_synced();
}

void KCCNode::set_synced(bool synced) {
    ((btKCC*) _character)->set_synced(synced);
}

PN_stdfloat KCCNode::get_vertical_velocity() {
    return (PN_stdfloat) ((btKCC*) _character)->get_vertical_velocity();
}

void KCCNode::set_vertical_velocity(PN_stdfloat v) {
    ((btKCC*) _character)->set_vertical_velocity((btScalar) v);
}

bool KCCNode::get_jumping() {
    return ((btKCC*) _character)->get_jumping();
}

void KCCNode::set_jumping(bool jumping) {
    ((btKCC*) _character)->set_jumping(jumping);
}
