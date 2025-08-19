/// Repository for IR command codes with merged duplicates
class CommandRepository {
  static const Map<String, List<int>> _irCodes = {
    'Elements_TV, Erisson_AL52D_B, Furrion, RCA_RLDED3258A-B, Sankey_TV': [
      0x20DF52AD,
    ],
    'GuestTek_Marriot_Hotel, Haier_L42C1180, Hisense_55K3201GUWUS, Hisense_55U6K, Hisense_U7G, LG, LG_24LJ4840, LG_32LF650V, LG_32LN5406, LG_32LW4500, LG_37LN5403, LG_43NANO779PA, LG_48LV340H, LG_4K_TV, LG_55LB870V_ZA, LG_55UN7300AUD, LG_75UJ6470, LG_AKB33871403, LG_AKB69680401, LG_AKB72913118, LG_AKB72914048, LG_AKB72915206, LG_AKB73275675, LG_AKB74915305, LG_AKB75095307, LG_AKB75375608, LG_AKB75675311, LG_AKB75855501, LG_AKB76043102, LG_C1, LG_C9_magic_remote, LG_Hotel_tv, LG_MKJ33981404, LG_MKJ39170828_Service, LG_MR21GC_Magic_Remote, LG_OLED48C37LA (LG_OLED C3 models), LG_OLED65C8PUA, LG_TV_42LF5800, LG_TV_AKB75375604, Marriott-BONVoY_Remote, SKYVUE_03SI-RI, Sharp_Roku_TV, SkyVue, Sunbrite, Sunbrite, Vizio, Vizio_D43-C1, Vizio_E190VA_Razor, Vizio_E70U-D3, Vizio_M70Q6-J03, Vizio_V405-H19, Vizio_V705-G1, Vizio_XRT122, Vizio_XRT135, Vizio_XRT136, Vizio_XRT150': [
      0x04FB08F7,
    ],
    'BAIRD_T15011DLEDDS_RC-6, Cranker_generic, SWEEX_Generic_Monitor, Westinghouse_RMT-13': [
      0x01FE10EF,
    ],
    'Manta_TV_2, RCA_RT2471_AC, RCA_TV_2': [
      0xA05F5FA0,
    ],
    'Enseo, Enseo_full': [
      0x6E9102FD,
    ],
    'Grandin_Unknown_Model, Kogan_KALED50XU9210STB, Oky_TV, Strong_TVD221_B1825, Supra_STV_LC32T880WL_1, Toshiba_32AV502U, Toshiba_CT-32F2, Toshiba_CT-90325, Toshiba_CT-9922, Toshiba_SE_R0305_32CV100U, United_tv': [
      0x40BF12ED,
    ],
    'BUSH_TV_VL32HDLED': [
      0x08F7D728,
    ],
    'ContinentalEdison_CELED32JBL7, Sencor_25801': [
      0x40BF0BF4,
    ],
    'Medion_MD21302': [
      0x19E618E7,
    ],
    'Android_TV_MXQ': [
      0x01FE40BF,
    ],
    'Grandin': [
      0x807F12ED,
    ],
    'CCE_RC512_Remote': [
      0x04FB40BF,
    ],
    'AORUS_Monitor': [
      0x00FF1AE5,
    ],
    'Sharp_g0684cesa_NES_TV': [
      0x28D70BF4,
    ],
    'NEC_E425': [
      0x38C701FE,
    ],
    'Sanyo_DP26640': [
      0x38C712ED,
    ],
    'Hitachi_LE46H508': [
      0x50AF17E8,
    ],
    'Strong_RCU-Z400N': [
      0xA05F1CE3,
    ],
    'Strong_STR7004': [
      0x01FE1CE3,
    ],
    'Daewood_Parsed': [
      0x807F827D,
    ],
    'Samsung': [
      0xE0E040BF,
      0xE0E0807F,
    ],
    'LG': [
      0x20DF10EF,
    ],
    'Sony': [
      0xA90F04FB,
    ],
    'Panasonic': [
      0x40040109,
    ],
    'Toshiba': [
      0xF20D04FB,
    ],
    'Sharp': [
      0xAA5504FB,
    ],
    'Vizio': [
      0x703AC03F,
    ],
    'Hisense': [
      0x4CB304FB,
    ],
    'TCL': [
      0x48B704FB,
    ],
    'Philips': [
      0xD82704FB,
    ],
    'JVC': [
      0xC13E04FB,
    ],
    'Sanyo': [
      0x55AA04FB,
    ],
    'Mitsubishi': [
      0xCD3204FB,
    ],
    'Insignia': [
      0xF50A04FB,
    ],
    'Element': [
      0xE51A04FB,
    ],
  };

  /// Get all shutdown codes for all brands as a flattened list
  List<int> getAllShutdownCodes() {
    return _irCodes.values.expand((codes) => codes).toList();
  }

  /// Get shutdown codes for a specific brand
  List<int>? getCodesForBrand(String brand) {
    return _irCodes[brand];
  }

  /// Get list of all supported brands
  List<String> getAllBrands() {
    return _irCodes.keys.toList();
  }

  /// Get count of supported brands
  int get brandCount => _irCodes.length;

  /// Get total count of all codes
  int get totalCodeCount =>
      _irCodes.values.fold(0, (sum, codes) => sum + codes.length);
}
