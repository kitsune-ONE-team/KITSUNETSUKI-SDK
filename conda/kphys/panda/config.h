#ifndef PANDA_CONFIG_H
#define PANDA_CONFIG_H
#pragma once

class btKinematicCharacterController;
class btKCC;

#include "pandabase.h"
#include "notifyCategoryProxy.h"

NotifyCategoryDecl(kcc, EXPORT_CLASS, EXPORT_TEMPL);

extern EXPORT_CLASS void init_libkcc();

#endif
