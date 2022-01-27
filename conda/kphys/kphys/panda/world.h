#ifndef PANDA_WORLD_H
#define PANDA_WORLD_H

#include "bulletWorld.h"
#include "kphys/bullet/world.h"


class EXPORT_CLASS World: public BulletWorld {
PUBLISHED:
    World();

private:
    static TypeHandle _type_handle;

protected:
    virtual void do_sync_p2b(PN_stdfloat dt, int num_substeps);
    virtual void do_sync_b2p();

public:
    static TypeHandle get_class_type() {
        return _type_handle;
    }
    static void init_type() {
        BulletWorld::init_type();
        register_type(
            _type_handle, "World",
            BulletWorld::get_class_type());
    }
    virtual TypeHandle get_type() const {
        return get_class_type();
    }
    virtual TypeHandle force_init_type() {
        init_type();
        return get_class_type();
    }

};

#endif
