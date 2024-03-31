#ifndef LOSTYLE_H
#define LOSTYLE_H

#include <QObject>
#include <QFont>
#include <QColor>
#include <QUrl>

class LOStyle: public QObject
{
    Q_OBJECT

    // Fonts
    // Q_PROPERTY( QFont h1 READ h1 CONSTANT )

    // Colors - primary palette
    Q_PROPERTY( QColor popupSemiTransparentColor READ popupSemiTransparentColor CONSTANT )
    Q_PROPERTY( QColor transparentColor READ transparentColor CONSTANT )
    Q_PROPERTY( QColor surfaceContainerLowColor READ surfaceContainerLowColor CONSTANT )
    Q_PROPERTY( QColor primaryColor READ primaryColor CONSTANT )
    Q_PROPERTY( QColor onPrimaryColor READ onPrimaryColor CONSTANT )
    Q_PROPERTY( QColor blackColor READ blackColor CONSTANT )
    Q_PROPERTY( QColor basicStripColor READ basicStripColor CONSTANT )
    Q_PROPERTY( QColor accentedStripColor READ accentedStripColor CONSTANT )
    Q_PROPERTY( QColor pressAccentColor READ pressAccentColor CONSTANT )
    Q_PROPERTY( QColor surfaceContainerHighColor READ surfaceContainerHighColor CONSTANT )
    Q_PROPERTY( QColor outlineVariant READ outlineVariant CONSTANT )
    Q_PROPERTY( QColor secondaryColor READ secondaryColor CONSTANT )
    Q_PROPERTY( QColor errorContainerColor READ errorContainerColor CONSTANT )
    Q_PROPERTY( QColor onSurfaceVariantColor READ onSurfaceVariantColor CONSTANT )
    Q_PROPERTY( QColor surfaceColor READ surfaceColor CONSTANT )
    Q_PROPERTY( QColor primary90Color READ primary90Color CONSTANT )
    Q_PROPERTY( QColor darkColor READ darkColor CONSTANT )
    Q_PROPERTY( QColor outlineColor READ outlineColor CONSTANT )
    // Q_PROPERTY( QColor READ  CONSTANT )

    // Colors - secondary palette
    Q_PROPERTY( QColor secondary50Color READ secondary50Color CONSTANT )

    // Colors - additional colors

    // Icons
    Q_PROPERTY( QUrl airportIcon READ airportIcon CONSTANT )
    Q_PROPERTY( QUrl documentationIcon READ documentationIcon CONSTANT )
    Q_PROPERTY( QUrl planeIcon READ planeIcon CONSTANT )
    Q_PROPERTY( QUrl flightsIcon READ flightsIcon CONSTANT )
    Q_PROPERTY( QUrl settinsIcon READ settinsIcon CONSTANT )
    Q_PROPERTY( QUrl rightChevronIcon READ rightChevronIcon CONSTANT )
    Q_PROPERTY( QUrl searchIcon READ searchIcon CONSTANT )
    Q_PROPERTY( QUrl passwordShownIcon READ passwordShownIcon CONSTANT )
    Q_PROPERTY( QUrl passwordHiddenIcon READ passwordHiddenIcon CONSTANT )
    Q_PROPERTY( QUrl arrowDropDownBigIcon READ arrowDropDownBigIcon CONSTANT )
    Q_PROPERTY( QUrl arrowDropUpBigIcon READ arrowDropUpBigIcon CONSTANT )
    Q_PROPERTY( QUrl arrowRightIcon READ arrowRightIcon CONSTANT )
    Q_PROPERTY( QUrl checkSmallIcon READ checkSmallIcon CONSTANT )
    Q_PROPERTY( QUrl closeIcon READ closeIcon CONSTANT )
    Q_PROPERTY( QUrl moreIcon READ moreIcon CONSTANT )
    Q_PROPERTY( QUrl menuIcon READ menuIcon CONSTANT )
    Q_PROPERTY( QUrl logoutIcon READ logoutIcon CONSTANT )
    Q_PROPERTY( QUrl editIcon READ editIcon CONSTANT )
    Q_PROPERTY( QUrl arrowDropDownMediumIcon READ arrowDropDownMediumIcon CONSTANT )
    // Q_PROPERTY( QUrl READ CONSTANT )
    // Q_PROPERTY( QUrl READ CONSTANT )


    // Q_PROPERTY( QUrl READ CONSTANT )

    // Filled Icons
    // Q_PROPERTY( QUrl projectsFilledIcon READ projectsFilledIcon CONSTANT )

    // Images
    Q_PROPERTY( QUrl logoImage READ logoImage CONSTANT )


    /*
     * Pixel sizes used across the app
     */
    // Icon sizes
    Q_PROPERTY( double icon24 READ number24 CONSTANT )
    Q_PROPERTY( double icon40 READ number40 CONSTANT )


    // Static heights/lenghts
    Q_PROPERTY( double searchbarHeight READ searchbarHeight CONSTANT)
    Q_PROPERTY( double toolbarHeight READ toolbarHeight CONSTANT) /*NOTIFY*/
    Q_PROPERTY( double drawerItemHeight READ drawerItemHeight CONSTANT )
    Q_PROPERTY( int maximumEmailInputLength READ maximumEmailInputLength CONSTANT )

    // Breakpoint to differentiate mobile landscape
    // Q_PROPERTY( double heightBreakpointXS READ number400 CONSTANT )

public:
    explicit LOStyle( QObject *parent )
        : QObject( parent )
    {}
    ~LOStyle() = default;


    //Colors
    QColor transparentColor() {return QColor::fromString( "transparent" );}
    QColor popupSemiTransparentColor() {return QColor::fromString( "#AACFDBE7" );}
    QColor surfaceContainerLowColor() {return QColor::fromString( "#F7F2FA" );}
    QColor primaryColor() {return QColor::fromString( "#6750A4");}
    QColor onPrimaryColor() {return QColor::fromString( "#FFFFFF" );}
    QColor blackColor() {return QColor::fromString( "#000000" );}
    QColor basicStripColor() {return QColor::fromString( "#F5EFF7" );}
    QColor accentedStripColor() {return QColor::fromString( "#FFD8E4" );}
    QColor pressAccentColor() {return QColor::fromString( "#D0BCFF" );}
    QColor surfaceContainerHighColor () {return QColor::fromString( "#ECE6F0" );}
    QColor outlineVariant() {return QColor::fromString( "#CAC4D0" );}
    QColor secondaryColor() {return QColor::fromString( "#625B71" );}
    QColor errorContainerColor() {return QColor::fromString( "#8C1D18" );}
    QColor onSurfaceVariantColor() {return QColor::fromString( "#49454F" );}
    QColor surfaceColor() {return QColor::fromString( "#FEF7FF" );}
    QColor primary90Color() {return QColor::fromString( "#EADDFF" );}
    QColor darkColor() {return QColor::fromString( "#322F35" );}
    QColor outlineColor() {return QColor::fromString( "#79747E" );}
    // QColor () {return QColor::fromString( "#" );}

    // Colors - secondary palette
    QColor secondary50Color() {return QColor::fromString( "#7A7289" );}

    //Images
    QUrl logoImage() {return QUrl( "qrc:/images/LetiskoLogo.svg" );}

    //Icons
    QUrl airportIcon() {return QUrl( "qrc:/icons/airport.svg" );}
    QUrl documentationIcon() {return QUrl( "qrc:/icons/documentation.svg" );}
    QUrl planeIcon() {return QUrl( "qrc:/icons/aircrafts.svg" );}
    QUrl flightsIcon() {return QUrl( "qrc:/icons/flights.svg" );}
    QUrl settinsIcon() {return QUrl( "qrc:/icons/settings.svg" );}
    QUrl rightChevronIcon() {return QUrl( "qrc:/icons/chevron_24px.svg" );}
    QUrl searchIcon() {return QUrl( "qrc:/icons/search-24px.svg" );}
    QUrl passwordShownIcon() {return QUrl( "qrc:/icons/visibility_on.svg" );}
    QUrl passwordHiddenIcon() {return QUrl( "qrc:/icons/visibility_off.svg" );}
    QUrl arrowDropDownBigIcon() {return QUrl( "qrc:/icons/arrow_drop_down_big.svg" );}
    QUrl arrowDropUpBigIcon() {return QUrl( "qrc:/icons/arrow_drop_up_big.svg" );}
    QUrl arrowRightIcon() {return QUrl( "qrc:/icons/arrow_right_40px.svg" );}
    QUrl checkSmallIcon() {return QUrl( "qrc:/icons/check_small-24px.svg" );}
    QUrl closeIcon() {return QUrl( "qrc:/icons/close-24px.svg" );}
    QUrl moreIcon() {return QUrl( "qrc:/icons/more-24px.svg" );}
    QUrl menuIcon() {return QUrl( "qrc:/icons/menu-24px.svg" );}
    QUrl logoutIcon  () {return QUrl( "qrc:/icons/logout_24px.svg" );}
    QUrl editIcon() {return QUrl( "qrc:/icons/edit_square_24px.svg" );}
    QUrl arrowDropDownMediumIcon() {return QUrl( "qrc:/icons/arrow_drop_down_medium.svg" );}
    // QUrl Icon() {return QUrl( "qrc:/icons/" );}

    // static QUrl Icon() {return QUrl( "qrc:/Icon.svg" );}


    double number24() {return 24;}
    double number40() {return 40;}

    double drawerItemHeight(){return 56;}
    double searchbarHeight(){return 56;}
    double toolbarHeight(){return 64;}
    int maximumEmailInputLength(){return 255;}
};

#endif // LOSTYLE_H
