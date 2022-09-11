--require("../../premake5-cuda")

local ROOT = "../../"

project  "OptixPremake"
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
  
  -- absolute path from solution root
  cudaPTXFiles { "sandbox/OptixPremake/**.cu" } -- files to be compiled into ptx
  --cudaKeep "On" -- keep temporary output files
  cudaFastMath "On"
  cudaRelocatableCode "On"
  cudaVerbosePTXAS "On"
  cudaMaxRegCount "32"
  
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
		

  cudaCompilerOptions {"-arch=sm_75", "-gencode=arch=compute_75,code=sm_75","-t0", "--expt-relaxed-constexpr", "--std c++17"} 

  cudaLinkerOptions { "-g" }
		
-- add settings common to all project
dofile("../../build_tools/common.lua")


