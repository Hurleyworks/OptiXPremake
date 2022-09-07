
local ROOT = "../"

	language "C++"

	defines{
		"JUCE_GLOBAL_MODULE_SETTINGS_INCLUDED", "OIIO_STATIC_DEFINE", "__TBB_NO_IMPLICIT_LINKAGE",
		--"_NEWTON_STATIC_LIB", "_CUSTOM_JOINTS_STATIC_LIB", "_DVEHICLE_STATIC_LIB",
		"_D_CORE_DLL","_D_TINY_DLL","_D_NEWTON_DLL","_D_COLLISION_DLL"
	}

	flags { "MultiProcessorCompile", "NoMinimalRebuild" }
	
	local CORE_DIR = ROOT .. "core/source/"
	local JAHLEY_DIR = ROOT .. "core/source/jahley/"
	local THIRD_PARTY_DIR = "../thirdparty/"
	local MODULE_DIR = "../modules/"
	
	local CUDA_INCLUDE_DIR = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/include"
	local CUDA_EXTRA_DIR = "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/extras/cupti/include"
	local CUDA_LIB_DIR =  "C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/lib/x64"
	
	local OPTIX_ROOT = "C:/ProgramData/NVIDIA Corporation"
	local OPTIX7_INCLUDE_DIR = OPTIX_ROOT .. "/OptiX SDK 7.4.0/include"
	local NEWTON_SDK_ROOT = "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/sdk/"
	
	includedirs
	{
		CORE_DIR,
		JAHLEY_DIR,
		MODULE_DIR,
		
		CUDA_INCLUDE_DIR,
		CUDA_EXTRA_DIR,
		OPTIX7_INCLUDE_DIR,
		
		THIRD_PARTY_DIR,
		THIRD_PARTY_DIR .. "glfw/include",
		THIRD_PARTY_DIR .. "nanogui/include",
		THIRD_PARTY_DIR .. "nanogui/ext/glad/include",
		THIRD_PARTY_DIR .. "nanogui/ext/nanovg/src",
		THIRD_PARTY_DIR .. "g3log/src",
		THIRD_PARTY_DIR .. "date/include/date",
		THIRD_PARTY_DIR .. "linalg/eigen34/Eigen",
		THIRD_PARTY_DIR .. "linalg/eigen34",
		THIRD_PARTY_DIR .. "benchmark/include",
		THIRD_PARTY_DIR .. "JUCE/modules",
		THIRD_PARTY_DIR .. "precompiled/include",
		THIRD_PARTY_DIR .. "precompiled/include/tbb",
		THIRD_PARTY_DIR .. "precompiled/include/CUBd",
		THIRD_PARTY_DIR .. "shockerUtil/src",
		THIRD_PARTY_DIR .. "precompiled/include/GLTFSDK/inc/",
		
		-- mitsuba
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/include/",
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/ext",
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/ext/drjit/include",
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/ext/drjit/ext/drjit-core/include",
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/ext/drjit/ext/drjit-core/ext/nanothread/include",
		THIRD_PARTY_DIR .. "precompiled/include/mitsuba3/ext/asmjit/src",
		THIRD_PARTY_DIR .. "precompiled/include/pugixml/src",
		THIRD_PARTY_DIR .. "precompiled/include/nanothread/include/nanothread",
		
		THIRD_PARTY_DIR .. "huse",
		THIRD_PARTY_DIR .. "huse/src",
		THIRD_PARTY_DIR .. "huse/src/splat",
		THIRD_PARTY_DIR .. "rapidobj/",
		THIRD_PARTY_DIR .. "cgltfReader",
		THIRD_PARTY_DIR .. "cgltfWriter",
		THIRD_PARTY_DIR .. "meshoptimizer/src/",
		THIRD_PARTY_DIR .. "fast_obj/source/",
		THIRD_PARTY_DIR .. "tinyformat",
		THIRD_PARTY_DIR .. "geometryCentral/include/geometryCentral",
		THIRD_PARTY_DIR .. "pmp/src",
		
		-- newton dll
		NEWTON_SDK_ROOT,
		NEWTON_SDK_ROOT .. "dCollision",
		NEWTON_SDK_ROOT .. "dCore",
		NEWTON_SDK_ROOT .. "dNewton",
		NEWTON_SDK_ROOT .. "dTinyxml",
		NEWTON_SDK_ROOT .. "dNewton/dJoints",
		NEWTON_SDK_ROOT .. "dNewton/dikSolver",
		NEWTON_SDK_ROOT .. "dNewton/dModels",
		NEWTON_SDK_ROOT .. "dNewton/dParticles",
		NEWTON_SDK_ROOT .. "dNewton/dModels/dVehicle",
		NEWTON_SDK_ROOT .. "dNewton/dModels/dCharacter",
		
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
			--"LITTLE_ENDIAN","__WINDOWS__",
			"NANOGUI_USE_OPENGL", "NANOGUI_GLAD",
		}
		
	filter "configurations:Debug"
		-- copy the tbb.dll into the executable folder
		postbuildcommands {
			"copy C:\\Users\\micro\\Desktop\\tbb\\Debug\\tbb.dll $(OutDir)",
			"copy D:\\ActiveWorks\\OpenSource\\latestNewton\\newton-dynamics\\newton-4.00\\build\\sdk\\Debug\\ndNewton_d.dll $(OutDir)",
			"copy D:\\ActiveWorks\\OpenSource\\latestNewton\\newton-dynamics\\newton-4.00\\build\\sdk\\dNewton\\dExtensions\\dCuda\\Debug\\ndSolverCuda_d.dll $(OutDir)",
		}
		links 
		{ 
			"Core",
			--"LWCore",
			"g3log",
			"nanogui",
			"GLFW",
			"benchmark",
			"JUCE",
			"huse",
			"tbb",
			"stb_image",
			"GLTFSDK",
			"meshoptimizer",
			"fast_obj",
			"cgltfReader",
			"cgltfWriter",
			"tinyexr",
			"shockerUtil",
			"geometryCentral",
			"pmp",
			"opengl32",
			
			--"Newton4SDK",
			"ndNewton_d",
			"ndSolverAvx2_d",
			--"ndSolverCuda_d",
			
			-- mitsuba3
			--"mitsuba-core",
			--"mitsuba-render",
			"mitsuba",
			"asmjit-mitsuba",
			"drjit-core",
			"pugixml",
			"nanothread",
			"drjit-autodiff",
			
			--cuda
			"libcubd_static",
			"cudart_static",
			"cuda",
			"nvrtc",
			"cublas",
			"curand",
			"cusolver",
			"cudart",
			"cudnn",
			
			--oiio
			"OpenImageIO_d",
			"OpenImageIO_Util_d",
			"Half-2_5_d",
			"Iex-2_5_d",
			"IexMath-2_5_d",
			"IlmImf-2_5_d",
			"IlmImfUtil-2_5_d",
			"IlmThread-2_5_d",
			"Imath-2_5_d",
			"jpeg",
			"turbojpeg",
			"tiffd",
			"zlibd",
			"lzmad",
			"libpng16d",
			"boost_thread-vc140-mt-gd",
			"boost_filesystem-vc140-mt-gd",
			"boost_system-vc140-mt-gd",
		}
		defines { "DEBUG", "USE_DEBUG_EXCEPTIONS", "EIGEN_NO_DEBUG" }
		symbols "On"
		libdirs { THIRD_PARTY_DIR .. "builds/bin/" .. outputdir .. "/**",
				  ROOT .. "builds/bin/" .. outputdir .. "/**",
				  THIRD_PARTY_DIR .. "precompiled/bin/" .. outputdir .. "/**",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/Debug",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/dNewton/dExtensions/dAvx2/Debug",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/dNewton/dExtensions/dCuda/Debug",
				  CUDA_LIB_DIR
		}
		
	filter "configurations:Release"
		-- copy the tbb.dll into the executable folder
		postbuildcommands {
			"copy C:\\Users\\micro\\Desktop\\tbb\\Release\\tbb.dll $(OutDir)",
			"copy D:\\ActiveWorks\\OpenSource\\latestNewton\\newton-dynamics\\newton-4.00\\build\\sdk\\Release\\ndNewton.dll $(OutDir)",
			"copy D:\\ActiveWorks\\OpenSource\\latestNewton\\newton-dynamics\\newton-4.00\\build\\sdk\\dNewton\\dExtensions\\dCuda\\Release\\ndSolverCuda.dll $(OutDir)",
		}
		links 
		{ 
			"Core",
			--"LWCore",
			"g3log",
			"nanogui",
			"GLFW",
			"benchmark",
			"JUCE",
			"huse",
			"tbb",
			"stb_image",
			"GLTFSDK",
			"meshoptimizer",
			"fast_obj",
			"cgltfReader",
			"cgltfWriter",
			"tinyexr",
			"shockerUtil",
			"geometryCentral",
			"pmp",
			"opengl32",
			
			--"Newton4SDK",
			"ndNewton",
			"ndSolverAvx2",
			--"ndSolverCuda",
			
			-- mitsuba3
			--"mitsuba-core",
			--"mitsuba-render",
			"mitsuba",
			"asmjit-mitsuba",
			"drjit-core",
			"pugixml",
			"nanothread",
			"drjit-autodiff",
			
			--cuda
			"libcubd_static",
			"cudart_static",
			"cuda",
			"nvrtc",
			"cublas",
			"curand",
			"cusolver",
			"cudart",
			"cudnn",
			
			--for 0ii0
			"OpenImageIO",
			"OpenImageIO_Util",
			"Half-2_5",
			"Iex-2_5",
			"IexMath-2_5",
			"IlmImf-2_5",
			"IlmImfUtil-2_5",
			"IlmThread-2_5",
			"Imath-2_5",
			"lzma",
			"jpeg",
			"turbojpeg",
			"libpng16",
			"tiff",
			"zlib",
			"boost_thread-vc140-mt",
			"boost_filesystem-vc140-mt",
			"boost_system-vc140-mt",
		}
		defines { "NDEBUG", "EIGEN_NO_DEBUG" }
		optimize "On"
		libdirs { THIRD_PARTY_DIR .. "builds/bin/" .. outputdir .. "/**",
				  ROOT .. "builds/bin/" .. outputdir .. "/**",
				  THIRD_PARTY_DIR .. "precompiled/bin/" .. outputdir .. "/**",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/Release",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/dNewton/dExtensions/dAvx2/Release",
				  "D:/ActiveWorks/OpenSource/latestNewton/newton-dynamics/newton-4.00/build/sdk/dNewton/dExtensions/dCuda/Release",
				  CUDA_LIB_DIR
		}
	
	  


	 		

