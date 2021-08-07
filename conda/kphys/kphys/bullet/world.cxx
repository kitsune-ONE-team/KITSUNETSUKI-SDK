#include "kphys/bullet/world.h"


btWorld::btWorld(
        btDispatcher* dispatcher, btBroadphaseInterface* pairCache,
        btConstraintSolver* constraintSolver, btCollisionConfiguration* collisionConfiguration,
        btSoftBodySolver* softBodySolver):
    btSoftRigidDynamicsWorld(
        dispatcher, pairCache, constraintSolver, collisionConfiguration, softBodySolver) {}
