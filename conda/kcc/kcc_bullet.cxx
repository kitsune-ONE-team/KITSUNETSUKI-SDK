#include "kcc_bullet.h"


btKCC::btKCC(btPairCachingGhostObject* ghostObject, btConvexShape* convexShape,
             btScalar stepHeight, const btVector3 & upAxis) :
    btKinematicCharacterController(ghostObject, convexShape, stepHeight, upAxis) {
    _is_synced = true;
}

btKCC::~btKCC() {
}

btScalar btKCC::get_vertical_velocity() {
    return m_verticalVelocity;
}

void btKCC::set_vertical_velocity(btScalar v) {
    m_verticalVelocity = v;
}

bool btKCC::get_jumping() {
    return m_wasJumping;
}

void btKCC::set_jumping(bool jumping) {
    m_wasJumping = jumping;
}

bool btKCC::get_synced() {
    return m_wasJumping;
}

void btKCC::set_synced(bool synced) {
    _is_synced = synced;
}

void btKCC::jump () {
    m_verticalVelocity = m_jumpSpeed;
    m_wasJumping = true;
}

virtual void btKCC::updateAction(btCollisionWorld* collisionWorld, btScalar deltaTime) {
    if (_is_synced) {
        preStep(collisionWorld);
        playerStep(collisionWorld, deltaTime);
    }
}
