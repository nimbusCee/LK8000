/*
 * LK8000 Tactical Flight Computer -  WWW.LK8000.IT
 * Released under GNU/GPL License v.2 or later
 * See CREDITS.TXT file for authors and copyrights
 *
 * $Id: devLX16xx.h,v 1.1 2011/12/21 10:35:29 root Exp root $
 */
//__________________________________________________________compilation_control_

#ifndef __DEVLXV7_H_
#define __DEVLXV7_H_

//_____________________________________________________________________includes_

#include "devBase.h"
#include "Devices/DeviceRegister.h"

//___________________________________________________________class_declarations_

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// General LX device (parsing LXWPn sentences).
///
class DevLXV7 : public DevBase
{


  //----------------------------------------------------------------------------
  public:

    /// Registers device into device subsystem.
    static constexpr
    DeviceRegister_t Register() {
        return devRegister(GetName(), Install);
    }

    // Send $PFLX2 to request Info from LX.
    static bool SetupLX_Sentence(PDeviceDescriptor_t d);

  //----------------------------------------------------------------------------
  protected:

    /// Protected only constructor - class should not be instantiated.
    DevLXV7() {}

    /// Installs device specific handlers.
    static void Install(PDeviceDescriptor_t d);

    /// Parses LXWPn sentences.
    static BOOL ParseNMEA(PDeviceDescriptor_t d, TCHAR* sentence, NMEA_INFO* info);

    static BOOL LXV7DirectLink(PDeviceDescriptor_t d, BOOL LinkStatus);
    /// Returns device name (max length is @c DEVNAMESIZE).
    static constexpr 
    const TCHAR* GetName() {
      return _T("LXV7");
    }

    /// Parses PLXVF sentence.
    static bool PLXVF(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses PLXVS sentence.
    static bool PLXVS(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses PLXV0 sentence.
    static bool PLXV0(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);
    /// Parses LXWP0 sentence.
    static bool LXWP0(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses LXWP1 sentence.
    static bool LXWP1(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses LXWP2 sentence.
    static bool LXWP2(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses LXWP3 sentence.
    static bool LXWP3(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

    /// Parses LXWP4 sentence.
    static bool LXWP4(PDeviceDescriptor_t d, const TCHAR* sentence, NMEA_INFO* info);

}; // DevLX

//______________________________________________________________________________

#endif // __DEVLXV7_H_
