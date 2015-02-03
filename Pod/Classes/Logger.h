//
//  Logger.h
//  Swig
//
//  Created by Pierre-Marc Airoldi on 2015-02-02.
//  Copyright (c) 2015 Pierre-Marc Airoldi. All rights reserved.
//

#ifndef Swig_Logger_h
#define Swig_Logger_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#undef LOG_LEVEL_DEF
#define LOG_LEVEL_DEF myLibLogLevel

#ifdef DEBUG
__unused static const int myLibLogLevel = DDLogLevelDebug;
#else
__unused static const int myLibLogLevel = DDLogLevelOff;
#endif

#endif
