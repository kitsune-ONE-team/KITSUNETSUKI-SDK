#ifndef NDEBUG
#include <time.h>
#define TIME_BEGIN t = (double) clock() / (CLOCKS_PER_SEC / 1000)
#define TIME_END(s) printf("%s %.6f ms\n", s, ((double) clock() / (CLOCKS_PER_SEC / 1000) - t))
#endif

#include "kphys/panda/world.h"


TypeHandle World::_type_handle;


World::World():
    BulletWorld() {
    delete _world;

    _world = new btWorld(_dispatcher, _broadphase, _solver, _configuration);
    nassertv(_world);
    nassertv(_world->getPairCache());

    _world->setWorldUserInfo(this);
    _world->setGravity(btVector3(0.0f, 0.0f, 0.0f));

    _filter_cb = &_filter_cb2;  // group masks
    _world->getPairCache()->setInternalGhostPairCallback(&_ghost_cb);
    _world->getPairCache()->setOverlapFilterCallback(_filter_cb);

    _world->getDispatchInfo().m_enableSPU = true;
    _world->getDispatchInfo().m_useContinuous = true;
    _world->getSolverInfo().m_splitImpulse = false;
    _world->getSolverInfo().m_numIterations = 10;
    // _world->getSolverInfo().m_numIterations = 1;
}

void World::do_sync_p2b(PN_stdfloat dt, int num_substeps) {
#ifndef NDEBUG
    double t;
    TIME_BEGIN;
#endif

    for (BulletRigidBodyNode* body: _bodies) {
        body->do_sync_p2b();
    }

#ifndef NDEBUG
    TIME_END("P2B RGD");
    TIME_BEGIN;
#endif

    for (BulletSoftBodyNode* softbody: _softbodies) {
        softbody->do_sync_p2b();
    }

#ifndef NDEBUG
    TIME_END("P2B SFT");
    TIME_BEGIN;
#endif

    for (BulletGhostNode* ghost: _ghosts) {
        ghost->do_sync_p2b();
    }

#ifndef NDEBUG
    TIME_END("P2B GHT");
    TIME_BEGIN;
#endif

    for (BulletBaseCharacterControllerNode* character: _characters) {
        character->do_sync_p2b(dt, num_substeps);
    }

#ifndef NDEBUG
    TIME_END("P2B CHC");
#endif
}

void World::do_sync_b2p() {
#ifndef NDEBUG
    double t;
    TIME_BEGIN;
#endif

    for (BulletRigidBodyNode* body: _bodies) {
        body->do_sync_b2p();
    }

#ifndef NDEBUG
    TIME_END("B2P RGD");
    TIME_BEGIN;
#endif

    for (BulletSoftBodyNode* softbody: _softbodies) {
        softbody->do_sync_b2p();
    }

#ifndef NDEBUG
    TIME_END("B2P STF");
    TIME_BEGIN;
#endif

    for (BulletGhostNode* ghost: _ghosts) {
        ghost->do_sync_b2p();
    }

#ifndef NDEBUG
    TIME_END("B2P GHT");
    TIME_BEGIN;
#endif

    for (BulletBaseCharacterControllerNode* character: _characters) {
        character->do_sync_b2p();
    }

#ifndef NDEBUG
    TIME_END("B2B CHC");
#endif
}
