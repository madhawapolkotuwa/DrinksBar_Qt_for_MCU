#include "SystemInterface.h"
// #include <string.h>

SystemInterface::SystemInterface(){
    currentPage.setValue("ui/HotCoolSelectScreen.qml");
    currentDrinkType.setValue(0);
    clearSelectedDrink();
    sugarLevel.setValue(0);
    size.setValue(0);
    sugarLevelText.setValue("");

    m_preparingTimer.setSingleShot(true);
    m_preparingTimer.setInterval(3000); // 3s
    doneTimeout _timeOut;
    _timeOut.model = this;
    m_preparingTimer.onTimeout(_timeOut);
}

void SystemInterface::clearSelectedDrink()
{
    selectedDrinkName.setValue("");
    selectedDrinkImage.setValue("");
    selectedDrinkGlassImage.setValue("");
    sugarLevelText.setValue("");
}

void SystemInterface::startPreparing()
{
    m_preparingTimer.start();

    printf("Drink: %s\n", selectedDrinkName.value().c_str() );

    switch (size.value()) {
    case 0:
        printf("Size: Large \n");
        break;
    case 1:
        printf("Size: Medium \n");
        break;
    case 2:
        printf("Size: Small \n");
        break;
    }

    printf("%s\n\r",sugarLevelText.value().c_str());

}


void SystemInterface::setCurrentPage(std::string pageUrl)
{
    // validation
    currentPage.setValue(pageUrl);
}

