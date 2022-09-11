#include "Jahley.h"

const std::string APP_NAME = "OptixPremake";

class Application : public Jahley::App
{
 public:
    Application() :
        Jahley::App()
    {
        try
        {
           
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
