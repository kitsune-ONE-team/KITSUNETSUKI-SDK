#ifndef KCC_NODE_HXX
#define KCC_NODE_HXX

#include "bulletCharacterControllerNode.h"
#include "bulletWorld.h"


/*
  Bullet KITSUNETSUKI Character Controller
*/
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
    void jump();
};


/*
  KITSUNETSUKI Character Controller Node
*/
class EXPORT_CLASS KCCNode : public BulletBaseCharacterControllerNode {
PUBLISHED:
    explicit KCCNode(BulletShape *shape, PN_stdfloat step_height,
                     const char *name="character");
    ~KCCNode() {
        delete _character;
        delete _ghost;
    }

    void set_linear_movement(const LVector3 &velocity, bool is_local);
    void set_angular_movement(PN_stdfloat omega);

    BulletShape *get_shape() const;

    void set_gravity(PN_stdfloat gravity);
    PN_stdfloat get_gravity() const;

    void set_fall_speed(PN_stdfloat fall_speed);
    void set_jump_speed(PN_stdfloat jump_speed);
    void set_max_jump_height(PN_stdfloat max_jump_height);

    void set_max_slope(PN_stdfloat max_slope);
    PN_stdfloat get_max_slope() const;

    void set_use_ghost_sweep_test(bool value);

    bool is_on_ground() const;
    bool can_jump() const;
    void do_jump();

    MAKE_PROPERTY(shape, get_shape);
    MAKE_PROPERTY(gravity, get_gravity, set_gravity);
    MAKE_PROPERTY(max_slope, get_max_slope, set_max_slope);
    MAKE_PROPERTY(on_ground, is_on_ground);

    PN_stdfloat get_vertical_velocity();
    void set_vertical_velocity(PN_stdfloat v);
    bool get_jumping();
    void set_jumping(bool jumping);

public:
    virtual btPairCachingGhostObject *get_ghost() const {
        return _ghost;
    }
    virtual btCharacterControllerInterface *get_character() const {
        return _character;
    }

    virtual void do_sync_p2b(PN_stdfloat dt, int num_substeps);
    virtual void do_sync_b2p();

protected:
    virtual void transform_changed();

private:
    CPT(TransformState) _sync;
    bool _sync_disable;

    BulletUpAxis _up;

    btKCC *_character;
    btPairCachingGhostObject *_ghost;

    PT(BulletShape) _shape;

    LVector3 _linear_movement;
    bool _linear_movement_is_local;
    PN_stdfloat _angular_movement;

    void do_transform_changed();

public:
    static TypeHandle get_class_type() {
        return _type_handle;
    }
    static void init_type() {
        BulletBaseCharacterControllerNode::init_type();
        register_type(_type_handle, "KCCNode",
                      BulletBaseCharacterControllerNode::get_class_type());
    }
    virtual TypeHandle get_type() const {
        return get_class_type();
    }
    virtual TypeHandle force_init_type() {
        init_type();
        return get_class_type();
    }

private:
    static TypeHandle _type_handle;
};

#endif
