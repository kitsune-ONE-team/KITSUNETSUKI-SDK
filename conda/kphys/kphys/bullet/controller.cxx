#include "kphys/bullet/controller.h"


btController::btController(
        btPairCachingGhostObject* ghostObject, btConvexShape* convexShape,
        btScalar stepHeight, const btVector3 & upAxis):
    btKinematicCharacterController(ghostObject, convexShape, stepHeight, upAxis) {
    _is_synced = true;
}

btScalar btController::get_vertical_velocity() {
    return m_verticalVelocity;
}

void btController::set_vertical_velocity(btScalar v) {
    m_verticalVelocity = v;
}

bool btController::get_jumping() {
    return m_wasJumping;
}

void btController::set_jumping(bool jumping) {
    m_wasJumping = jumping;
}

bool btController::get_synced() {
    return m_wasJumping;
}

void btController::set_synced(bool synced) {
    _is_synced = synced;
}

void btController::jump () {
    m_verticalVelocity = m_jumpSpeed;
    m_wasJumping = true;
}

void btController::updateAction(btCollisionWorld* collisionWorld, btScalar deltaTime) {
    if (_is_synced) {
        preStep(collisionWorld);
        playerStep(collisionWorld, deltaTime);
    }
}
