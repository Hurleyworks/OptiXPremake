#include "Jahley.h"

const std::string APP_NAME = "HelloOptiX";

#include <reproc++/run.hpp>

class Application : public Jahley::App
{
 public:
    Application() :
        Jahley::App()
    {
        try
        {
            LOG (DBUG) << "Hello OptiX!";
			
            // path to nvcc exe
            std::string exe ("C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/bin/nvcc.exe");

			// nvcc args
            std::vector<std::string> args;
            args.push_back (exe);

            args.push_back ("D:/ActiveWorks/OpenSource/hurleyworks/OptiXPremake/sandbox/HelloOptiX/source/kernels_0.cu");

            args.push_back ("--ptx");
            args.push_back ("--extended-lambda");
            args.push_back ("--use_fast_math");
            args.push_back ("--cudart");
            args.push_back ("shared");
            args.push_back ("--std");
            args.push_back ("c++17");
            args.push_back ("-rdc");
            args.push_back ("true");
            args.push_back ("--expt-relaxed-constexpr");
            args.push_back ("--machine");
            args.push_back ("64");
            args.push_back ("--gpu-architecture");
            args.push_back ("sm_75");

            // NB if the ptx files are not being saved, first thing to do is check to make sure
            // this path is correct. It will be wrong if you have updated to a new version of vs2019
            args.push_back ("--compiler-bindir");
            args.push_back ("C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64");

            // OptiX 7.4 headers
            args.push_back ("--include-path");
            args.push_back ("C:/ProgramData/NVIDIA Corporation/OptiX SDK 7.4.0/include");

            // cuda 11.7 headers
            args.push_back ("--include-path");
            args.push_back ("C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v11.7/include");

            // OptixUtil
            args.push_back ("--include-path");
            args.push_back ("D:/ActiveWorks/OpenSource/hurleyworks/OptiXPremake/thirdparty/optiXUtil/src");

            args.push_back ("--output-file");
            args.push_back ("D:/ActiveWorks/OpenSource/hurleyworks/OptiXPremake/sandbox/HelloOptiX/source/kernels_0.ptx");

            int status = -1;
            std::error_code errCode;

            reproc::options options;
            options.redirect.parent = true;
            options.deadline = reproc::milliseconds (5000);

            std::tie (status, errCode) = reproc::run (args, options);

            if (errCode)
            {
                LOG (CRITICAL) << errCode.message();
            }
        }
        catch (std::exception& e)
        {
            LOG (CRITICAL) << e.what();
        }
    }

    ~Application()
    {
    }

    void onCrash() override
    {
    }

 private:
};

Jahley::App* Jahley::CreateApplication()
{
    return new Application();
}
