
local ROOT = "../"

	language "C++"

	defines{
	}

	flags { "MultiProcessorCompile", "NoMinimalRebuild" }
	
	local CORE_DIR = ROOT .. "core/source/"
	local JAHLEY_DIR = ROOT .. "core/source/jahley/"
	local THIRD_PARTY_DIR = "../thirdparty/"
	
	local CUDA_INCLUDE_DIR = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/include"
	local CUDA_EXTRA_DIR = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/extras/cupti/include"
	local CUDA_LIB_DIR =  "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/lib/x64"
	
	local OPTIX_ROOT = "C:/ProgramData/NVIDIA Corporation"
	local OPTIX7_INCLUDE_DIR = OPTIX_ROOT .. "/OptiX SDK 7.4.0/include"
	
	includedirs
	{
		CORE_DIR,
		JAHLEY_DIR,
		
		CUDA_INCLUDE_DIR,
		CUDA_EXTRA_DIR,
		OPTIX7_INCLUDE_DIR,
		
		THIRD_PARTY_DIR,
		THIRD_PARTY_DIR .. "g3log/src",
		THIRD_PARTY_DIR .. "optiXUtil/src",
		THIRD_PARTY_DIR .. "reproc++",
		
	}
	
	targetdir (ROOT .. "builds/bin/" .. outputdir .. "/%{prj.name}")
	objdir (ROOT .. "builds/bin-int/" .. outputdir .. "/%{prj.name}")
	
	filter { "system:windows"}
		disablewarnings { 
			"5030", "4244", "4267", "4667", "4018", "4101", "4305", "4316", "4146", "4996",
		} 
		linkoptions { "-IGNORE:4099" } -- can't find debug file in release folder
		characterset ("MBCS")
		buildoptions { "/Zm250", "/bigobj",}
		
		defines 
		{ 
			"WIN32", "_WINDOWS",
			--https://github.com/KjellKod/g3log/issues/337
			"_SILENCE_CXX17_RESULT_OF_DEPRECATION_WARNING",
		}
		
	filter "configurations:Debug"
		links 
		{ 
			"Core",
			"g3log",
			"optiXUtil",
			"reproc++",
			-- for reproc++
			"ws2_32",
			
			--cuda
			"cudart_static",
			"cuda",
			"nvrtc",
			"cublas",
			"curand",
			"cusolver",
			"cudart",
			"cudnn",
	
		}
		defines { "DEBUG", "USE_DEBUG_EXCEPTIONS", "EIGEN_NO_DEBUG" }
		symbols "On"
		libdirs { THIRD_PARTY_DIR .. "builds/bin/" .. outputdir .. "/**",
				  ROOT .. "builds/bin/" .. outputdir .. "/**",
				  CUDA_LIB_DIR
		}
		
	filter "configurations:Release"
		links 
		{ 
			"Core",
			"g3log",
			"optiXUtil",
			"reproc++",
			-- for reproc++
			"ws2_32",
			
			--cuda
			"cudart_static",
			"cuda",
			"nvrtc",
			"cublas",
			"curand",
			"cusolver",
			"cudart",
			"cudnn",
			
		}
		defines { "NDEBUG", "EIGEN_NO_DEBUG" }
		optimize "On"
		libdirs { THIRD_PARTY_DIR .. "builds/bin/" .. outputdir .. "/**",
				  ROOT .. "builds/bin/" .. outputdir .. "/**",
				  CUDA_LIB_DIR
		}
	
	  


	 		

