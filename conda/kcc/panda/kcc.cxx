#include "panda/kcc.h"


static const btVector3 up_vectors[3] = {btVector3(1.0f, 0.0f, 0.0f), btVector3(0.0f, 1.0f, 0.0f), btVector3(0.0f, 0.0f, 1.0f)};

TypeHandle KCCNode::_type_handle;


KCCNode::KCCNode(BulletShape *shape, PN_stdfloat step_height, const char *name) : BulletBaseCharacterControllerNode(name) {
    // Synchronised transform
    _sync = TransformState::make_identity();
    _sync_disable = false;

    // Initial transform
    btTransform trans = btTransform::getIdentity();

    // Get convex shape (for ghost object)
    if (!shape->is_convex()) {
        // bullet_cat.error() << "a convex shape is required!" << std::endl;
        return;
    }

    btConvexShape *convex = (btConvexShape *)(shape->ptr());

    // Ghost object
    _ghost = new btPairCachingGhostObject();
    _ghost->setUserPointer(this);

    _ghost->setWorldTransform(trans);
    _ghost->setInterpolationWorldTransform(trans);
    _ghost->setCollisionShape(convex);
    _ghost->setCollisionFlags(btCollisionObject::CF_CHARACTER_OBJECT);

    // Up axis
    _up = get_default_up_axis();

    // Initialise movement
    _linear_movement_is_local = false;
    _linear_movement.set(0.0f, 0.0f, 0.0f);
    _angular_movement = 0.0f;

    // Character controller
    _character = new btKCC(_ghost, convex, step_height, up_vectors[_up]);
    _character->setGravity(up_vectors[_up] * -(btScalar)9.81f);

    // Retain a pointer to the shape
    _shape = shape;

    // Default collide mask TODO set_into_collide_mask(CollideMask::all_on());
}

void KCCNode::set_linear_movement(const LVector3 &movement, bool is_local) {
    LightMutexHolder holder(BulletWorld::get_global_lock());

    nassertv(!movement.is_nan());

    _linear_movement = movement;
    _linear_movement_is_local = is_local;
}

void KCCNode::set_angular_movement(PN_stdfloat omega) {
    LightMutexHolder holder(BulletWorld::get_global_lock());

    _angular_movement = omega;
}

void KCCNode::do_sync_p2b(PN_stdfloat dt, int num_substeps) {
    // Synchronise global transform
    do_transform_changed();

    // Angular rotation
    btScalar angle = dt * deg_2_rad(_angular_movement);

    btMatrix3x3 m = _ghost->getWorldTransform().getBasis();
    btVector3 up = m[_up];

    m *= btMatrix3x3(btQuaternion(up, angle));

    _ghost->getWorldTransform().setBasis(m);

    // Linear movement
    LVector3 vp = _linear_movement / (btScalar)num_substeps;

    btVector3 v;
    if (_linear_movement_is_local) {
        btTransform xform = _ghost->getWorldTransform();
        xform.setOrigin(btVector3(0.0f, 0.0f, 0.0f));
        v = xform(LVecBase3_to_btVector3(vp));
    }
    else {
        v = LVecBase3_to_btVector3(vp);
    }

    // _character->setVelocityForTimeInterval(v, dt);
    _character->setWalkDirection(v * dt);
    _angular_movement = 0.0f;
}

void KCCNode::do_sync_b2p() {
    NodePath np = NodePath::any_path((PandaNode *)this);
    LVecBase3 scale = np.get_net_transform()->get_scale();

    btTransform trans = _ghost->getWorldTransform();
    CPT(TransformState) ts = btTrans_to_TransformState(trans, scale);

    LMatrix4 m_sync = _sync->get_mat();
    LMatrix4 m_ts = ts->get_mat();

    if (!m_sync.almost_equal(m_ts)) {
        _sync = ts;
        _sync_disable = true;
        np.set_transform(NodePath(), ts);
        _sync_disable = false;
    }
}

void KCCNode::do_transform_changed() {
    if (_sync_disable) return;

    NodePath np = NodePath::any_path((PandaNode *)this);
    CPT(TransformState) ts = np.get_net_transform();

    LMatrix4 m_sync = _sync->get_mat();
    LMatrix4 m_ts = ts->get_mat();

    if (!m_sync.almost_equal(m_ts)) {
        _sync = ts;

        // Get translation, heading and scale
        LPoint3 pos = ts->get_pos();
        PN_stdfloat heading = ts->get_hpr().get_x();
        LVecBase3 scale = ts->get_scale();

        // Set translation
        _character->warp(LVecBase3_to_btVector3(pos));

        // Set Heading
        btMatrix3x3 m = _ghost->getWorldTransform().getBasis();
        btVector3 up = m[_up];

        m = btMatrix3x3(btQuaternion(up, deg_2_rad(heading)));

        _ghost->getWorldTransform().setBasis(m);

        // Set scale
        _shape->do_set_local_scale(scale);
    }
}

void KCCNode::transform_changed() {
    if (_sync_disable) return;

    LightMutexHolder holder(BulletWorld::get_global_lock());

    do_transform_changed();
}

BulletShape *KCCNode::get_shape() const {
    return _shape;
}

bool KCCNode::is_on_ground() const {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    return _character->onGround();
}

bool KCCNode::can_jump() const {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    return _character->canJump();
}

void KCCNode::do_jump() {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->jump();
}

void KCCNode::set_fall_speed(PN_stdfloat fall_speed) {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->setFallSpeed((btScalar)fall_speed);
}

void KCCNode::set_jump_speed(PN_stdfloat jump_speed) {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->setJumpSpeed((btScalar)jump_speed);
}

void KCCNode::set_max_jump_height(PN_stdfloat max_jump_height) {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->setMaxJumpHeight((btScalar)max_jump_height);
}

void KCCNode::set_max_slope(PN_stdfloat max_slope) {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->setMaxSlope((btScalar)max_slope);
}

PN_stdfloat KCCNode::get_max_slope() const {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    return (PN_stdfloat)_character->getMaxSlope();
}

PN_stdfloat KCCNode::get_gravity() const {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    return -(PN_stdfloat)_character->getGravity()[_up];
}

void KCCNode::set_gravity(PN_stdfloat gravity) {
    LightMutexHolder holder(BulletWorld::get_global_lock());
    _character->setGravity(up_vectors[_up] * -(btScalar)gravity);
}

void KCCNode::set_use_ghost_sweep_test(bool value) {
  LightMutexHolder holder(BulletWorld::get_global_lock());
  return _character->setUseGhostSweepTest(value);
}

PN_stdfloat KCCNode::get_vertical_velocity() {
    return (PN_stdfloat) _character->get_vertical_velocity();
}

void KCCNode::set_vertical_velocity(PN_stdfloat v) {
    _character->set_vertical_velocity((btScalar) v);
}

bool KCCNode::get_jumping() {
    return _character->get_jumping();
}

void KCCNode::set_jumping(bool jumping) {
    _character->set_jumping(jumping);
}

bool KCCNode::get_synced() {
    return _character->get_synced();
}

void KCCNode::set_synced(bool synced) {
    _character->set_synced(synced);
}
