#pragma once

#ifndef DRINKSMODEL_H
#define DRINKSMODEL_H

#include "qul/listproperty.h"
#include <qul/model.h>
#include <platforminterface/allocator.h>

#include <string.h>

#include "jsmn/jsmn.h"
#include "fatfs/fatfsfilesystem.h"


struct DrinkItem
{
    int id;
    std::string name;
    std::string image;
    std::string glassImage;
};

inline bool operator == (const DrinkItem &lhs, const DrinkItem &rhs){
    return (lhs.id == rhs.id && lhs.name == rhs.name);
}

static std::string tokenString(const std::string &json, const jsmntok_t *tok) {
    return std::string(json.c_str() + tok->start, tok->end - tok->start);
}

static int jsoneq(const char *json, jsmntok_t *tok, const char *s) {
    if (tok->type == JSMN_STRING && (int)strlen(s) == tok->end - tok->start &&
        strncmp(json + tok->start, s, tok->end - tok->start) == 0) {
        return 0; // The strings are equal
    }
    return -1; // The strings are not equal
}

static void loadJsonData(const char* jsonDrinksKey, Qul::DynamicList<DrinkItem>& data) {

    FatFsFilesystem fatFsFileSystem;
    jsmn_parser paser;

    std::string jsonResult;
    jsonResult = fatFsFileSystem.loadTextFile("/j.json");

    if(jsonResult.empty())
    {
        printf("Error in Json File loading...\n");
        return;
    }

    printf("Json file loaded..\n");

    jsmntok_t tokens[520]; // 8kb

    jsmn_init(&paser);
    int r = jsmn_parse(&paser, jsonResult.c_str(), jsonResult.size(), tokens, sizeof(tokens) / sizeof(tokens[0]));


    if(r < 0) {
        printf("Falid to parse JSON\n");
        return;
    }

    int index = 0;

    for(int i=1; i<r; i++){
        if(jsoneq(jsonResult.c_str(), &tokens[i], jsonDrinksKey) == 0){
            jsmntok_t *arr_tok = &tokens[i + 1];
            if (arr_tok->type != JSMN_ARRAY) continue;
            int current_item_idx = i + 2;
            for (int j = 0; j < arr_tok->size; j++){
                jsmntok_t *obj_tok = &tokens[current_item_idx];
                if (obj_tok->type != JSMN_OBJECT) break;

                DrinkItem drinkItem;

                for (int k = 0; k < obj_tok->size; k++){
                    jsmntok_t *key = &tokens[current_item_idx + 1 + 2*k];
                    jsmntok_t *val = &tokens[current_item_idx + 2 + 2*k];

                    if(jsoneq(jsonResult.c_str(), key, "id") == 0){
                        drinkItem.id = std::stoi(tokenString(jsonResult, val));
                    } else if (jsoneq(jsonResult.c_str(), key, "name") == 0) {
                        drinkItem.name = tokenString(jsonResult, val);
                        printf("    Name: %.*s\n", val->end - val->start, jsonResult.c_str() + val->start);
                    } else if (jsoneq(jsonResult.c_str(), key, "image") == 0) {
                        drinkItem.image = tokenString(jsonResult, val);
                        //printf("    Image: %.*s\n", val->end - val->start, jsonResult.c_str() + val->start);
                    } else if (jsoneq(jsonResult.c_str(), key, "glassImage") == 0){
                        drinkItem.glassImage = tokenString(jsonResult, val);
                       // printf("    glassImage: %.*s\n", val->end - val->start, jsonResult.c_str() + val->start);
                    }
                }

                data.append(drinkItem);
                current_item_idx += (1 + 2 * obj_tok->size);
            }


        }
    }
}

struct HotDrinksModel : Qul::ListModel<DrinkItem>
{
private:
    Qul::DynamicList<DrinkItem> m_data;

public:
    // Implement the ListModel interface
    int count() const QUL_DECL_OVERRIDE { return m_data.count(); }
    DrinkItem data(int index) const QUL_DECL_OVERRIDE { return m_data[index]; }

    HotDrinksModel() {
        loadJsonData("hotDrinks", m_data);
    }
};

struct CoolDrinksModel : Qul::ListModel<DrinkItem>
{
private:
    Qul::DynamicList<DrinkItem> m_data;

public:
    // Implement the ListModel interface
    int count() const QUL_DECL_OVERRIDE { return m_data.count(); }
    DrinkItem data(int index) const QUL_DECL_OVERRIDE { return m_data[index]; }

    CoolDrinksModel() {
        loadJsonData("coolDrinks", m_data);
    }
};

struct FreshJuiceModel : Qul::ListModel<DrinkItem>
{
private:
    Qul::DynamicList<DrinkItem> m_data;

public:
    // Implement the ListModel interface
    int count() const QUL_DECL_OVERRIDE { return m_data.count(); }
    DrinkItem data(int index) const QUL_DECL_OVERRIDE { return m_data[index]; }

    FreshJuiceModel() {
        loadJsonData("freshJuices", m_data);
    }
};




#endif // DRINKSMODEL_H
