
-- https://github.com/JohannesMP/Premake-for-Beginners

-- Include the premake5 CUDA module
require('premake5-cuda')

workspace "OptiXPremake"
	architecture "x64"
	location ("builds")

if _ACTION == "vs2019" then
   location ("builds/VisualStudio2019")
end
if _ACTION == "vs2022" then
   location ("builds/VisualStudio2022")
end

	configurations 
	{ 
		"Debug", 
        "Release",
    }
	vectorextensions "AVX2"
	filter "configurations:Debug"    defines { "DEBUG" }  symbols  "On"
    filter "configurations:Release"  defines { "NDEBUG" } optimize "On"
    
	outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
local ROOT = "../../"

-- the core
project "Core"
    kind "StaticLib"
    language "C++"
	defines {  }
	flags { "MultiProcessorCompile", "NoMinimalRebuild" }
	
	if _ACTION == "vs2019" then
		cppdialect "C++17"
		location "builds/VisualStudio2019/projects"
	end
	if _ACTION == "vs2022" then
		cppdialect "C++17"
		location ("builds/VisualStudio2022/projects")
	end
	
	targetdir ("builds/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("builds/bin-int/" .. outputdir .. "/%{prj.name}")

	local SOURCE_DIR = "core/source/"
	local BERSERKO_DIR = "core/source/jahley/"

    files
    { 
      SOURCE_DIR .. "**.h", 
      SOURCE_DIR .. "**.hpp", 
      SOURCE_DIR .. "**.c",
      SOURCE_DIR .. "**.cpp",
      SOURCE_DIR .. "**.tpp",
    }
	
	local THIRD_PARTY_DIR = "thirdparty/"
	includedirs
	{
		SOURCE_DIR,
		BERSERKO_DIR,
		
		THIRD_PARTY_DIR,
		THIRD_PARTY_DIR .. "g3log/src",
	}
	
	filter {} -- clear filter!
	
	
	filter "system:windows"
        staticruntime "On"
        systemversion "latest"
		characterset ("MBCS")
        disablewarnings { 
			"5030", "4244", "4267", "4667", "4018", "4101", "4305", "4316", "4146", "4996",
		} 
		buildoptions { "/Zm250", "/bigobj",}
		
		defines 
		{ 
			"_CRT_SECURE_NO_WARNINGS",
			
			--https://github.com/KjellKod/g3log/issues/337
			"_SILENCE_CXX17_RESULT_OF_DEPRECATION_WARNING",
			"_USE_MATH_DEFINES", "NOMINMAX",
			
		}
		
		 -- setting up visual studio filters (basically virtual folders).
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
	
	filter "configurations:Debug"
        defines {"USE_DEBUG_EXCEPTIONS"}
    
	
   include "sandbox/HelloWorld"
   include "sandbox/HelloOptiX"