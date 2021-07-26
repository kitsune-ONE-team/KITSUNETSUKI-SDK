#ifndef CONFIG_KCC_H
#define CONFIG_KCC_H
#pragma once

class btKinematicCharacterController;
class btKCC;

#include "pandabase.h"
#include "notifyCategoryProxy.h"

NotifyCategoryDecl(kcc, EXPORT_CLASS, EXPORT_TEMPL);

extern EXPORT_CLASS void init_libkcc();

#endif
