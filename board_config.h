#pragma once

#include "stm32f7xx_hal.h"

void ConfigureBoard();

RTC_TimeTypeDef GetRTC_Time();

RTC_DateTypeDef GetRTC_Date();

void Set_Date_Time(RTC_TimeTypeDef sTime, RTC_DateTypeDef sDate);
