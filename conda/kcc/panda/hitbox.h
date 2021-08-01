#ifndef PANDA_HITBOX_H
#define PANDA_HITBOX_H

#include "bullet/bulletBodyNode.h"


class EXPORT_CLASS HitboxNode : public BulletBodyNode {
PUBLISHED:
    bool get_synced_b2p();
    void set_synced_b2p(bool synced);

    bool get_synced_p2b();
    void set_synced_p2b(bool synced);

private:
    bool _is_synced_b2p;
    bool _is_synced_p2b;
};

#endif
