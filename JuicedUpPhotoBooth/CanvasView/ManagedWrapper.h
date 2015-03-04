/*===================================================================================*/
// This file defines some static routines so that ImageWarper can be used in managed
// environment, and for simpler interface 
// without the need of managing actual processing classes.
//
// Freely use at your own risk.
//
// Vu Pham
//
/*===================================================================================*/

#ifndef __MANAGEDWRAPPER_H__
#define __MANAGEDWRAPPER_H__

#include <map>
#include "Warper.h"
#include "WarperUtil.h"
using namespace ImageWarper;
using namespace std;

static std::map<int, ImageWarper::Warper*> m_warpers;
static std::map<int, ImageWarper::WarpedImage*> m_warpedImages;

/*======================================================================*/
// Exported functions
/*======================================================================*/

extern "C" DLLEXPORTED int CreateWarper
	(int width, int height, int scanWidth, int bpp, unsigned char* rawData);

extern "C" DLLEXPORTED int ReleaseWarper(int warperId);

extern "C" DLLEXPORTED void BeginWarp
	(int warperId, int centerX, int centerY, int brushSize, int warperType);

extern "C" DLLEXPORTED unsigned char* UpdateWarp
	(int warperId, int x, int y, 
	int *xRet, int *yRet, int *width, int *height, int* scanWidth);

extern "C" DLLEXPORTED unsigned char* EndWarp
	(int warperId, int *xRet, int *yRet, int *width, int *height, int* scanWidth);

/*======================================================================*/
// Private utilities functions
/*======================================================================*/

static int getNextWarperId();
static Warper* getMapItemW(std::map<int, Warper*> & map, int iId);
static WarpedImage* getMapItemWI(std::map<int, WarpedImage*> & map, int iId);

template<class T>
static T getMapItem(std::map<int, T> &map, int iId);

//static ImageWarper::Warper* getMapItem(std::map<int, ImageWarper::Warper*> &map, int iId);
//static ImageWarper::WarpedImage* getMapItem(std::map<int, ImageWarper::WarpedImage*> &map, int iId);

#endif