#include "Jahley.h"

const std::string APP_NAME = "HelloOptiX";

class Application : public Jahley::App
{
 public:
    Application () :
        Jahley::App()
    {
        try
        {
            LOG(DBUG) << "Hello OptiX!";
        }
        catch (std::exception& e)
        {
            std::cout << e.what() << std::endl;
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
