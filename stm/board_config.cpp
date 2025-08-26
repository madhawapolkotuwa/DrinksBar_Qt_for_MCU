/******************************************************************************
**
** Copyright (C) 2023 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/
#include "board_config.h"
#include "fatfs/fatfsfilesystem.h"

#include "ff.h"
#include "ff_gen_drv.h"

#include <platforminterface/log.h>
#include <platform/mem.h>

#include <qul/application.h>

extern "C" const Diskio_drvTypeDef SD_Driver;

RTC_HandleTypeDef hrtc;

extern "C" {
    void _Error_Handler(const char *file, int line);
    void SystemClock_Config(void)
    {
        RCC_OscInitTypeDef RCC_OscInitStruct;
        RCC_ClkInitTypeDef RCC_ClkInitStruct;
        RCC_PeriphCLKInitTypeDef PeriphClkInitStruct;

        /** Configure LSE Drive Capability
        */
        HAL_PWR_EnableBkUpAccess();
        __HAL_RCC_LSEDRIVE_CONFIG(RCC_LSEDRIVE_LOW);

        /**Configure the main internal regulator output voltage
         */
        __HAL_RCC_PWR_CLK_ENABLE();
        __HAL_RCC_SYSCFG_CLK_ENABLE();

        __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

        /**Initializes the CPU, AHB and APB busses clocks
         */
        RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE | RCC_OSCILLATORTYPE_LSE;
        RCC_OscInitStruct.HSEState = RCC_HSE_ON;
        RCC_OscInitStruct.LSEState = RCC_LSE_ON;
        RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
        RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
        RCC_OscInitStruct.PLL.PLLM = 25;
        RCC_OscInitStruct.PLL.PLLN = 432;
        RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
        RCC_OscInitStruct.PLL.PLLQ = 4;
        RCC_OscInitStruct.PLL.PLLR = 2;
        if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK) {
            _Error_Handler(__FILE__, __LINE__);
        }

        /**Activate the Over-Drive mode
         */
        if (HAL_PWREx_EnableOverDrive() != HAL_OK) {
            _Error_Handler(__FILE__, __LINE__);
        }

        /**Initializes the CPU, AHB and APB busses clocks
         */
        RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2;
        RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
        RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
        RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
        RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;

        if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_7) != HAL_OK) {
            _Error_Handler(__FILE__, __LINE__);
        }

        PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_USART1;
        PeriphClkInitStruct.Usart1ClockSelection = RCC_USART1CLKSOURCE_PCLK2;
        if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) != HAL_OK) {
            _Error_Handler(__FILE__, __LINE__);
        }

        /**Configure the Systick interrupt time
         */
        HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq() / 1000);

        /**Configure the Systick
         */
        HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

        /* SysTick_IRQn interrupt configuration */
        HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);

    }

    void HAL_RTC_MspInit(RTC_HandleTypeDef* hrtc)
    {

        RCC_PeriphCLKInitTypeDef PeriphClkInitStruct = {0};
        if(hrtc->Instance==RTC)
        {
            /* USER CODE BEGIN RTC_MspInit 0 */

            /* USER CODE END RTC_MspInit 0 */

            /** Initializes the peripherals clock
      */
            PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_RTC;
            PeriphClkInitStruct.RTCClockSelection = RCC_RTCCLKSOURCE_LSE;
            if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) != HAL_OK)
            {
                printf("Error in RTC_Msp initialization..\n");
            }

            /* Peripheral clock enable */
            __HAL_RCC_RTC_ENABLE();

            printf("Done RTC_Msp initialization..\n");
        }
    }

}


void RTC_Init()
{
    RTC_TimeTypeDef sTime = {0};
    RTC_DateTypeDef sDate = {0};

    /** Initialize RTC Only
  */
    hrtc.Instance = RTC;
    hrtc.Init.HourFormat = RTC_HOURFORMAT_24;
    hrtc.Init.AsynchPrediv = 127;
    hrtc.Init.SynchPrediv = 255;
    hrtc.Init.OutPut = RTC_OUTPUT_DISABLE;
    hrtc.Init.OutPutPolarity = RTC_OUTPUT_POLARITY_HIGH;
    hrtc.Init.OutPutType = RTC_OUTPUT_TYPE_OPENDRAIN;
    if (HAL_RTC_Init(&hrtc) != HAL_OK)
    {
        printf("Error in RTC initialization..\n");
        return;
    }

    /** Initialize RTC and set the Time and Date
  */
    sTime.Hours = 0x9;
    sTime.Minutes = 0x32;
    sTime.Seconds = 0x0;
    sTime.DayLightSaving = RTC_DAYLIGHTSAVING_NONE;
    sTime.StoreOperation = RTC_STOREOPERATION_RESET;
    if (HAL_RTC_SetTime(&hrtc, &sTime, RTC_FORMAT_BCD) != HAL_OK)
    {
        printf("Error in RTC Time set..\n");
    }
    sDate.WeekDay = RTC_WEEKDAY_THURSDAY;
    sDate.Month = RTC_MONTH_AUGUST;
    sDate.Date = 0x24;
    sDate.Year = 0x25;
    if (HAL_RTC_SetDate(&hrtc, &sDate, RTC_FORMAT_BCD) != HAL_OK)
    {
        printf("Error in RTC Date set..\n");
    }

    printf("Done RTC initialization..\n");
}

void ConfigureBoard()
{

    // FatFs File system
    static FatFsFilesystem filesystem;

    static FATFS sdFatFs;
    static char sdPath[4];

    if (FATFS_LinkDriver(&SD_Driver, sdPath) != 0) {
        Qul::PlatformInterface::log("FATFS_LinkDriver failed\n");
        return;
    }

    if (f_mount(&sdFatFs, sdPath, 0) != 0) {
        Qul::PlatformInterface::log("Mounting filesystem failed!\n");
        return;
    }

    Qul::Application::addFilesystem(&filesystem);

    // RTC
    RTC_Init();
}

RTC_TimeTypeDef GetRTC_Time()
{
    RTC_TimeTypeDef sTime;
    HAL_RTC_GetTime(&hrtc, &sTime, RTC_FORMAT_BIN);
    return sTime;
}

RTC_DateTypeDef GetRTC_Date()
{
    RTC_DateTypeDef sDate;
    HAL_RTC_GetDate(&hrtc, &sDate, RTC_FORMAT_BIN);
    return sDate;
}

void Set_Date_Time(RTC_TimeTypeDef sTime, RTC_DateTypeDef sDate) {
    if (HAL_RTC_SetTime(&hrtc, &sTime, RTC_FORMAT_BIN) != HAL_OK)
    {
        printf("Error in RTC time set..");
    }

    if (HAL_RTC_SetDate(&hrtc, &sDate, RTC_FORMAT_BIN) != HAL_OK)
    {
        printf("Error in RTC date set..");
    }
}

extern "C" {

    void *ff_memalloc(UINT msize)
    {
        return Qul::Platform::qul_malloc(msize);
    }

    void ff_memfree(void *ptr)
    {
        Qul::Platform::qul_free(ptr);
    }

}

