#include "dconfig.h"
#include "kphys/panda/config.h"
#include "kphys/panda/controller.h"
#include "kphys/panda/hitbox.h"
#include "kphys/panda/spring.h"
#include "kphys/panda/world.h"


Configure(config_kphys);
NotifyCategoryDef(kphys , "");


ConfigureFn(config_kphys) {
    init_libkphys();
}


void init_libkphys() {
    static bool initialized = false;
    if (initialized) return;
    initialized = true;

    ControllerNode::init_type();
    HitboxNode::init_type();
    SpringConstraint::init_type();
    World::init_type();

    return;
}
