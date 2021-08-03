#ifndef PANDA_KCC_H
#define PANDA_KCC_H

#include "bulletCharacterControllerNode.h"
#include "bullet/kcc.h"


class EXPORT_CLASS KCCNode : public BulletCharacterControllerNode {
PUBLISHED:
    explicit KCCNode(
        BulletShape *shape, PN_stdfloat step_height,
        const char *name="character");
    ~KCCNode() {
        delete _character;
        delete _ghost;
    }

    PN_stdfloat get_vertical_velocity();
    void set_vertical_velocity(PN_stdfloat v);

    bool get_jumping();
    void set_jumping(bool jumping);

    bool get_synced();
    void set_synced(bool synced);

public:
    virtual void do_sync_p2b(PN_stdfloat dt, int num_substeps);
    virtual void do_sync_b2p();

    static TypeHandle get_class_type() {
        return _type_handle;
    }
    static void init_type() {
        BulletCharacterControllerNode::init_type();
        register_type(
            _type_handle, "KCCNode",
            BulletCharacterControllerNode::get_class_type());
    }
    virtual TypeHandle get_type() const {
        return get_class_type();
    }
    virtual TypeHandle force_init_type() {
        init_type();
        return get_class_type();
    }

private:
    bool _is_synced;

    static TypeHandle _type_handle;
};

#endif
