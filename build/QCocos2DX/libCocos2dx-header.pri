## latest cocos2d-x using c++11 or c++0x, so you will see below.
QMAKE_CXXFLAGS += -std=c++11
QMAKE_CXXFLAGS += -stdlib=libc++
QMAKE_LFLAGS += -lc++
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7

# disble the Qt keywords extension here for cocos2d-x 3.x,
# there is some qt extension keywords in code.
DEFINES += QT_NO_KEYWORDS

SOURCE_ROOT_DIR = $$PWD/../..
COCOS2D_DIR = $$SOURCE_ROOT_DIR

DEFINES += CC_TARGET_QT5
DEFINES += USE_FILE32API
DEFINES += CC_KEYBOARD_SUPPORT

DEFINES += __QT__
DEFINES += CC_UNDER_QT
DEFINES += COCOS2D_DEBUG=2

macx {
    # system libraries.
    INCLUDEPATH += /usr/local/include
    LIBS += -L/usr/local/lib/ -lGLEW
    LIBS += -L/usr/local/lib/ -lz

    LIBS    += -framework Cocoa
    LIBS    += -framework Foundation
    LIBS    += -framework OpenAL

    # prebuilt libraries
    INCLUDEPATH += $$PWD/../../external/png/include/mac
    LIBS        += -L$$PWD/../../external/png/prebuilt/mac -lpng

    INCLUDEPATH += $$PWD/../../external/tiff/include/mac
    LIBS        += -L$$PWD/../../external/tiff/prebuilt/mac -ltiff

    INCLUDEPATH += $$PWD/../../external/jpeg/include/mac
    LIBS += -L$$PWD/../../external/jpeg/prebuilt/mac -ljpeg

    INCLUDEPATH += $$PWD/../../external/curl/include/mac
    LIBS        += -L$$PWD/../../external/curl/prebuilt/mac -lcurl

#    INCLUDEPATH += $$PWD/../../external/glfw3/include/mac
#    LIBS += -L$$PWD/../../external/glfw3/prebuilt/mac -lglfw3

    INCLUDEPATH += $$PWD/../../external/openal/include
    LIBS += -L$$PWD/../../external/openal/prebuilt/mac -lopenal

    INCLUDEPATH += $$PWD/../../external/freealut/include
    LIBS += -L$$PWD/../../external/freealut/prebuilt/mac -lalut

    INCLUDEPATH += $$PWD/../../external/libvorbis/include
    LIBS += -L$$PWD/../../external/libvorbis/prebuilt/mac -lvorbis
    LIBS += -L$$PWD/../../external/libvorbis/prebuilt/mac -lvorbisenc
    LIBS += -L$$PWD/../../external/libvorbis/prebuilt/mac -lvorbisfile

    INCLUDEPATH += $$PWD/../../external/sqlite3/include
    LIBS += -L$$PWD/../../external/sqlite3/libraries/mac -lsqlite3

    INCLUDEPATH += $$PWD/../../external/freetype2/include/mac
    LIBS += -L$$PWD/../../external/freetype2/prebuilt/mac -lfreetype

    INCLUDEPATH += $$PWD/../../external/websockets/include/mac
    LIBS += -L$$PWD/../../external/websockets/prebuilt/mac -lwebsockets

    INCLUDEPATH += $$PWD/../../external/webp/include/mac
    LIBS += -L$$PWD/../../external/webp/prebuilt/mac -lwebp

#    INCLUDEPATH += $$PWD/../../external/lua/luajit/include
#    LIBS += -L$$PWD/../../external/lua/luajit/prebuilt/mac -lluajit

    contains(TEMPLATE, app) {
        APP_BUNDLE_PATH  = $${DESTDIR}/$${TARGET}.app
        DYLIB_PATH  = $${DESTDIR}/libcocos2d.1.0.0.dylib

        message(------------------------BEGIN------------------------------)
        ## checking `DESTDIR`, 3rd party programmer must define the `DESTDIR` before including ME in your own project.
        count(DESTDIR, 0) {
            message("`DESTDIR` is empty, Setting `DESTDIR` before including `libCocos2dx-header.pri`")
        }
        message($$APP_BUNDLE_PATH)
        message($$DYLIB_PATH)
        message(-------------------------END-------------------------------)

        QMAKE_POST_LINK     += ${QTDIR}/bin/macdeployqt $$APP_BUNDLE_PATH -verbose=1 &
        contains(CONFIG, shared) {
            QMAKE_POST_LINK += cp -f $$DYLIB_PATH $$APP_BUNDLE_PATH/Contents/Frameworks/libcocos2d.1.dylib &
            QMAKE_POST_LINK += cp -f $$PWD/../../external/openal/prebuilt/mac/*openal*.dylib    $$APP_BUNDLE_PATH/Contents/Frameworks &
        }
    }
}

COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/2d
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/2d/platform
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/2d/platform/qt
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/2d/platform/renderer
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/audio/include
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/base
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/math/kazmath
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/storage/local-storage
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/ui
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/physics
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/physics/chipmunk
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/editor-support
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/editor-support/spine
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/editor-support/cocosbuilder
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/editor-support/cocostudio
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/scripting/lua-bindings/auto
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/cocos/scripting/lua-bindings/manual
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/chipmunk/include
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/chipmunk/include/chipmunk
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/edtaa3func
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/tinyxml2
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/unzip
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/xxhash
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/json
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/extensions
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/extensions/GUI
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua/tolua
#COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua/lua
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua/luajit/include
COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua/luajit/src/src
#COCOS2D_INCLUDEPATH +=    $$COCOS2D_DIR/external/lua/luasocket


INCLUDEPATH += $$COCOS2D_INCLUDEPATH


