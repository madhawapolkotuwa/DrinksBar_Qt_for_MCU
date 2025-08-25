#ifndef FATFSFILESYSTEM_H
#define FATFSFILESYSTEM_H

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
#include "ff.h"
#include "ff_gen_drv.h"

#include <platforminterface/allocator.h>
#include <platforminterface/filesystem.h>
#include <string>

class FatFsFile : public Qul::PlatformInterface::File
{
public:
    FatFsFile(FIL fileHandle)
        : m_fileHandle(fileHandle)
        , m_valid(true)
    {}

    ~FatFsFile() { close(); }

    uint64_t size() QUL_DECL_OVERRIDE
    {
        if (!m_valid)
            return 0;

        return f_size(&m_fileHandle);
    }

    int read(unsigned char *outputBuffer, uint64_t startOffset, unsigned int readSize) QUL_DECL_OVERRIDE
    {
        if (!m_valid)
            return -1;

        UINT bytesRead;

        if (f_lseek(&m_fileHandle, startOffset) != FR_OK)
            return -1;

        if (f_read(&m_fileHandle, outputBuffer, readSize, &bytesRead) != FR_OK)
            return -1;

        return bytesRead;
    }

    int close() QUL_DECL_OVERRIDE
    {
        if (!m_valid)
            return -1;

        m_valid = false;
        return f_close(&m_fileHandle);
    }

private:
    FIL m_fileHandle;
    bool m_valid;
};

class FatFsFilesystem : public Qul::PlatformInterface::Filesystem
{
public:
    Qul::PlatformInterface::File* open(const char *fileName, Qul::PlatformInterface::File::Mode) QUL_DECL_OVERRIDE
    {
        FRESULT fr;
        FIL fp;

        fr = f_open(&fp, fileName, FA_READ | FA_OPEN_ALWAYS);
        if (fr == FR_OK){
            return Qul::PlatformInterface::qul_new<FatFsFile>(fp);
        }

        return NULL;
    }

    std::string loadTextFile(const char *fileName)
    {
        FIL file;

        if(f_open(&file, fileName, FA_READ) != FR_OK) {

            printf("Failed to f_open \n");

            return {};
        }

        std::string result;
        result.resize(f_size(&file)); // allocate exact size

        UINT bytesRead;
        f_read(&file, result.data(), result.size(), &bytesRead);

        f_close(&file);

        result.resize(bytesRead); // trim to actual size
        return result;
    }


};

#endif // FATFSFILESYSTEM_H
