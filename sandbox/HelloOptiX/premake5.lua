--	require("../../premake5-cuda")

local ROOT = "../../"

project  "HelloOptiX"
	if _ACTION == "vs2019" then
		cppdialect "C++17"
		location (ROOT .. "builds/VisualStudio2019/projects")
    end
	
	if _ACTION == "vs2022" then
		cppdialect "C++17"
		location (ROOT .. "builds/VisualStudio2022/projects")
    end
	
	kind "ConsoleApp"

	local SOURCE_DIR = "source/*"
    files
    { 
      SOURCE_DIR .. "**.h", 
      SOURCE_DIR .. "**.hpp", 
      SOURCE_DIR .. "**.c",
      SOURCE_DIR .. "**.cpp",
    }
	
  buildcustomizations "BuildCustomizations/CUDA 11.7"

  externalwarnings "Off" -- thrust gives a lot of warnings
  cudaFiles { "source/exe/cu/**.cu" } -- files to be compiled into binaries
  cudaPTXFiles { "sandbox/HelloOptiX/source/exe/ptx/**.cu" } -- files to be compiled into ptx
  cudaKeep "On" -- keep temporary output files
  cudaFastMath "On"
  cudaRelocatableCode "On"
  cudaVerbosePTXAS "On"
  cudaMaxRegCount "32"
  
	includedirs
	{
	
	}
	
	filter "system:windows"
		staticruntime "On"
		systemversion "latest"
		defines {"_CRT_SECURE_NO_WARNINGS","NOMINMAX",
		}
		
		disablewarnings { "5030" , "4305", "4316", "4267"}
		vpaths 
		{
		  ["Header Files/*"] = { 
			SOURCE_DIR .. "**.h", 
			SOURCE_DIR .. "**.hxx", 
			SOURCE_DIR .. "**.hpp",
		  },
		  ["Source Files/*"] = { 
			SOURCE_DIR .. "**.c", 
			SOURCE_DIR .. "**.cxx", 
			SOURCE_DIR .. "**.cpp",
		  },
		}
		
		 -- Let's compile for all supported architectures (and also in parallel with -t0)
  cudaCompilerOptions {"-arch=sm_52", "-gencode=arch=compute_52,code=sm_52", "-gencode=arch=compute_60,code=sm_60",
    "-gencode=arch=compute_61,code=sm_61", "-gencode=arch=compute_70,code=sm_70",
    "-gencode=arch=compute_75,code=sm_75", "-gencode=arch=compute_80,code=sm_80",
    "-gencode=arch=compute_86,code=sm_86", "-gencode=arch=compute_86,code=compute_86", "-t0"} 

  cudaLinkerOptions { "-g" }
		
-- add settings common to all project
dofile("../../build_tools/common.lua")


