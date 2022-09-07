
extern Jahley::App* Jahley::CreateApplication();

int main (int argc, char** argv)
{
    Jahley::App* app = Jahley::CreateApplication();
    delete app;

    std::cout << "Press ENTER to continue...";
    std::cin.ignore (std::numeric_limits<std::streamsize>::max(), '\n');
}