#ifndef SYSTEMINTERFACE_H
#define SYSTEMINTERFACE_H

#include <qul/singleton.h>
#include <qul/property.h>
#include <string>

#include <qul/listproperty.h>
#include <qul/timer.h>
#include <qul/signal.h>


class SystemInterface : public Qul::Singleton<SystemInterface>
{
public:
    friend class Qul::Singleton<SystemInterface>;

    Qul::Property<std::string> currentPage;
    void setCurrentPage(std::string pageUrl);

    void clearSelectedDrink();

    Qul::Property<int> currentDrinkType;

    Qul::Property<std::string> selectedDrinkName;
    Qul::Property<std::string> selectedDrinkImage;
    Qul::Property<std::string> selectedDrinkGlassImage;

    Qul::Property<int> sugarLevel;
    Qul::Property<int> size;
    Qul::Property<std::string> sugarLevelText;

    void startPreparing();

    Qul::Signal<void()> doneDrinkOrder;


private:
    SystemInterface();
    SystemInterface(const SystemInterface&);
    SystemInterface &operator = (const SystemInterface&);

    struct doneTimeout {
        SystemInterface* model;

        void operator()() {
            model->doneDrinkOrder();
        }
    };


    void ClearSelectedDrink();

    Qul::Timer m_preparingTimer;

};

#endif // SYSTEMINTERFACE_H
