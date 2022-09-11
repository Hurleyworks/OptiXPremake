
/*

   Copyright 2022 Shin Watanabe

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

*/

#include "shared.h"

using namespace shared;

RT_PIPELINE_LAUNCH_PARAMETERS PipelineLaunchParameters1 plp;

CUDA_DEVICE_KERNEL void RT_RG_NAME (rg0)()
{
    uint32_t value = 0;
    optixu::trace<Pipeline0Payload0Signature> (
        plp.travHandle,
        make_float3 (0, 0, 0), make_float3 (0, 0, 1), 0.0f, INFINITY, 0.0f,
        0xFF, OPTIX_RAY_FLAG_NONE,
        0, 1, 0,
        value);
}

CUDA_DEVICE_KERNEL void RT_EX_NAME (ex0)() {}

CUDA_DEVICE_KERNEL void RT_MS_NAME (ms0)() {}

CUDA_DEVICE_KERNEL void RT_CH_NAME (ch0)()
{
    float3 value;
    Pipeline1Payload0Signature::get (&value);
    value = make_float3 (value.x + 1, value.y + 1, value.z + 1);
    Pipeline1Payload0Signature::set (&value);
}

CUDA_DEVICE_KERNEL void RT_CH_NAME (ch1)()
{
    float3 value;
    Pipeline1Payload0Signature::get (&value);
    value = make_float3 (value.x + 2, value.y + 2, value.z + 2);
    Pipeline1Payload0Signature::set (&value);
}

CUDA_DEVICE_KERNEL void RT_AH_NAME (ah0)() {}

CUDA_DEVICE_KERNEL void RT_IS_NAME (is0)() {}

CUDA_DEVICE_KERNEL void RT_DC_NAME (dc0)() {}

CUDA_DEVICE_KERNEL void RT_CC_NAME (cc0)() {}
