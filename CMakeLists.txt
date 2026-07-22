cmake_minimum_required(VERSION 3.16)

project(Mentorus VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appMentorus
    src/main.cpp
)

set_source_files_properties(
    qml/theme/ColorPalette.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appMentorus
    URI Mentorus
    QML_FILES
        qml/Main.qml
        qml/components/WindowButton.qml
        qml/pages/MainPage.qml
        qml/components/UiButton.qml
        qml/components/TopBar.qml
        qml/theme/ColorPalette.qml
        qml/components/LineEdit.qml
        qml/pages/Dashboard.qml
        qml/components/QuickActionsCard.qml

    RESOURCES
        assets/fonts/Lexend.ttf
        assets/icons/close.png
        assets/icons/maximize.png
        assets/icons/minimize.png
        assets/icons/restore.png
        assets/icons/search.png
        assets/icons/book.png
        assets/icons/quiz.png
        assets/icons/cards.png
        assets/icons/calendar.png
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMentorus PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMentorus
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMentorus
    PRIVATE Qt6::Quick
)

install(TARGETS appMentorus
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
