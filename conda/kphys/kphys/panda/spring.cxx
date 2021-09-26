#include "kphys/panda/spring.h"


TypeHandle SpringConstraint::_type_handle;


SpringConstraint::SpringConstraint(
        const BulletRigidBodyNode* node_a,
	const BulletRigidBodyNode* node_b,
	const TransformState* frame_a,
	const TransformState* frame_b,
	bool use_frame_a_ref) {

    btRigidBody* ptr_a = btRigidBody::upcast(node_a->get_object());
    btRigidBody* ptr_b = btRigidBody::upcast(node_b->get_object());

    btTransform trans_a = TransformState_to_btTrans(frame_a);
    btTransform trans_b = TransformState_to_btTrans(frame_b);

#ifdef USE_SPRING_V2
    _constraint = new btGeneric6DofSpring2Constraint(
	*ptr_a, *ptr_b, trans_a, trans_b);
#else
    _constraint = new btGeneric6DofSpringConstraint(
	*ptr_a, *ptr_b, trans_a, trans_b, use_frame_a_ref);
#endif
}

void SpringConstraint::set_spring(int dof, bool enabled) {
    _constraint->enableSpring(dof, enabled);
}

void SpringConstraint::set_stiffness(int dof, double value) {
    _constraint->setStiffness(dof, (btScalar) value);
}

void SpringConstraint::set_damping(int dof, double value) {
    _constraint->setDamping(dof, (btScalar) value);
}

void SpringConstraint::set_limit(int dof, double min, double max) {
    /*
      Set constraint limits for translation and rotation.

      :param dof: Degree Of Freedom to set (0-5)
      :type dof: int

      :param min: min value (in degrees for rotation angles)
      :type min: double

      :param max: max value (in degrees for rotation angles)
      :type max: double
     */
    if (dof < 3) {  // translation
	_constraint->setLimit(dof, (btScalar) min, (btScalar) max);
    } else {  // rotation - degrees to radians
	_constraint->setLimit(
	    dof, (btScalar) (min * M_PI / 180), (btScalar) (max * M_PI / 180));
    }
}

void SpringConstraint::set_equilibrium_point(int dof) {
    _constraint->setEquilibriumPoint(dof);
}

void SpringConstraint::set_equilibrium_point(int dof, double value) {
    _constraint->setEquilibriumPoint(dof, (btScalar) value);
}

#ifdef USE_SPRING_V2
void SpringConstraint::set_rotation_order(int order) {
    _constraint->setRotationOrder(order);
}

void SpringConstraint::set_bounce(int dof, double value) {
    _constraint->setBounce(dof, (btScalar) value);
}

void SpringConstraint::set_motor(int dof, bool enabled) {
    _constraint->enableMotor(dof, enabled);
}

void SpringConstraint::set_motor_servo(int dof, bool enabled) {
    _constraint->setServo(dof, enabled);
}

void SpringConstraint::set_target_velocity(int dof, double value) {
    _constraint->setTargetVelocity(dof, (btScalar) value);
}

void SpringConstraint::set_servo_target(int dof, double value) {
    _constraint->setServoTarget(dof, (btScalar) value);
}

void SpringConstraint::set_max_motor_force(int dof, double value) {
    _constraint->setMaxMotorForce(dof, (btScalar) value);
}
#endif
