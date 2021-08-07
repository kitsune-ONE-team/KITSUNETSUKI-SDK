#ifndef BULLET_WORLD_H
#define BULLET_WORLD_H


#ifdef CPPPARSER  // interrogate parser
#include <btBulletDynamicsCommon.h>  // panda3d parser-inc
#include <kphys/interrogate.h>

#else  // normal compiler
#include <BulletCollision/CollisionDispatch/btGhostObject.h>
#include <BulletSoftBody/btSoftRigidDynamicsWorld.h>

#endif


class btHitboxPairCallback: public btGhostPairCallback {
public:
    btHitboxPairCallback() {}

    virtual btBroadphasePair* addOverlappingPair(
            btBroadphaseProxy* proxy0,
            btBroadphaseProxy* proxy1) {
        return 0;
    }

    virtual void* removeOverlappingPair(
            btBroadphaseProxy* proxy0,
            btBroadphaseProxy* proxy1, btDispatcher* dispatcher) {
        return 0;
    }

    virtual void removeOverlappingPairsContainingProxy(
            btBroadphaseProxy* proxy0, btDispatcher* dispatcher) {
        btAssert(0);
    }
};


class btWorld: public btSoftRigidDynamicsWorld {
public:
    btWorld(
        btDispatcher* dispatcher, btBroadphaseInterface* pairCache,
        btConstraintSolver* constraintSolver, btCollisionConfiguration* collisionConfiguration,
        btSoftBodySolver* softBodySolver = 0);
};

#endif
