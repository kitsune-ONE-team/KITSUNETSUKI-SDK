#ifndef KCC_BULLET_H
#define KCC_BULLET_H

#include <BulletDynamics/Character/btKinematicCharacterController.h>
#include <BulletSoftBody/btSoftRigidDynamicsWorld.h>


class btKCC : public btKinematicCharacterController {
public:
    BT_DECLARE_ALIGNED_ALLOCATOR();

    btKCC(btPairCachingGhostObject* ghostObject, btConvexShape* convexShape,
          btScalar stepHeight, const btVector3 & upAxis = btVector3(1.0,0.0,0.0));
    ~btKCC();

    btScalar get_vertical_velocity();
    void set_vertical_velocity(btScalar v);
    bool get_jumping();
    void set_jumping(bool jumping);
    bool get_synced();
    void set_synced(bool synced);
    void jump();

    virtual void updateAction(btCollisionWorld* collisionWorld, btScalar deltaTime);

private:
    bool _is_synced;
};

#endif
