
#pragma once

#include <iostream>

#if defined(_WIN32) || defined(_WIN64)
#define __FUNCTION_NAME__ __func__
#define _FN_ __FUNCTION_NAME__
#ifndef NOMINMAX
#define NOMINMAX
#endif
#include <Windows.h>
#undef near
#undef far
#undef RGB
#endif

// g3log
#include <g3log/g3log.hpp>
#include <g3log/logworker.hpp>

const LEVELS TESTING{ INFO.value + 1, "TESTING" };
const LEVELS CRITICAL{ WARNING.value + 1, "CRTICAL" };

