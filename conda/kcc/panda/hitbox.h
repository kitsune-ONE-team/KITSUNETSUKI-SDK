#ifndef PANDA_HITBOX_H
#define PANDA_HITBOX_H

#include "bulletGhostNode.h"


class EXPORT_CLASS HitboxNode : public BulletGhostNode {
PUBLISHED:
    explicit HitboxNode(const char *name="ghost");
    /* ~HitboxNode() { */
    /*     delete _ghost; */
    /* } */

    void do_sync_p2b();
    void do_sync_b2p();

    bool get_synced_b2p();
    void set_synced_b2p(bool synced);

    bool get_synced_p2b();
    void set_synced_p2b(bool synced);

public:
    static TypeHandle get_class_type() {
        return _type_handle;
    }
    static void init_type() {
        BulletGhostNode::init_type();
        register_type(
            _type_handle, "HitboxNode",
            BulletGhostNode::get_class_type());
    }
    virtual TypeHandle get_type() const {
        return get_class_type();
    }
    virtual TypeHandle force_init_type() {
        init_type();
        return get_class_type();
    }

private:
    bool _is_synced_b2p;
    bool _is_synced_p2b;

    static TypeHandle _type_handle;
};

#endif
