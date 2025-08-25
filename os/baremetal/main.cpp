#include "board_config.h"
#include "DrinksBar.h"

#include <qul/application.h>
#include <qul/qul.h>



int main ()
{
    Qul::initHardware();

    Qul::initPlatform();
    ConfigureBoard();

    Qul::Application _qul_app;
    static struct ::DrinksBar _qul_item;
    _qul_app.setRootItem(&_qul_item);
    _qul_app.exec();
    return 0;
}
