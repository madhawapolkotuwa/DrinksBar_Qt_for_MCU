#ifndef DATETIMEPROVIDER_H
#define DATETIMEPROVIDER_H

#include <qul/singleton.h>
#include <qul/property.h>
#include <cstdio>
#include <ctime>
#include <string.h>
#include <stdio.h>
#include <string>

#if !defined(STM32F769xx)
#define STM32F769xx
#endif

#include "board_config.h"


class DateTimeProvider : public Qul::Singleton<DateTimeProvider>
{
public:
    friend class Qul::Singleton<DateTimeProvider>;

    Qul::Property<std::string> dateTime;

    Qul::Property<int> year;
    Qul::Property<int> month;
    Qul::Property<int> date;
    Qul::Property<int> hours;
    Qul::Property<int> minutes;

    void refreshDateTime() {
        RTC_TimeTypeDef currentTime = GetRTC_Time();
        RTC_DateTypeDef currentDate = GetRTC_Date();

        char buffer[50];

        year.setValue(currentDate.Year);
        month.setValue(currentDate.Month);
        date.setValue(currentDate.Date);

        hours.setValue(currentTime.Hours);
        minutes.setValue(currentTime.Minutes);

        sprintf(buffer, "%02d:%02d | %02d-%02d-20%02d",currentTime.Hours, currentTime.Minutes, currentDate.Date, currentDate.Month, currentDate.Year);

        dateTime.setValue(buffer);
    }

    void setTimeAndDate() {
        RTC_TimeTypeDef _time;
        _time.Hours = hours.value();
        _time.Minutes = minutes.value();
        _time.Seconds = 0;

        RTC_DateTypeDef _date;
        _date.Year = year.value();
        _date.Month = month.value();
        _date.Date = date.value();

        // printf("Year: %02d, Month: %02d, Date: %02d | Hours: %02d, Minutes: %2d \n\r", _date.Year, _date.Month, _date.Date,_time.Hours,_time.Minutes);

        Set_Date_Time(_time,_date);

        refreshDateTime();
    }

private:
    DateTimeProvider() {}

};

#endif // DATETIMEPROVIDER_H
