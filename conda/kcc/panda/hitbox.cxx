#include "panda/hitbox.h"


TypeHandle HitboxNode::_type_handle;


bool HitboxNode::
get_synced_b2p() {
    return _is_synced_b2p;
}

void HitboxNode::
set_synced_b2p(bool synced) {
    _is_synced_b2p = synced;
}

bool HitboxNode::
get_synced_p2b() {
    return _is_synced_p2b;
}

void HitboxNode::
set_synced_p2b(bool synced) {
    _is_synced_p2b = synced;
}

void HitboxNode::
do_sync_b2p() {
    if (_is_synced_b2p) {
        BulletGhostNode::do_sync_b2p();
    }
}

void HitboxNode::
do_sync_p2b() {
    if (_is_synced_p2b) {
        BulletGhostNode::do_sync_p2b();
    }
}
