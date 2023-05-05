import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountriesUtil{

  static final Map<String, LatLng> _countryLocations = {
    // Africa
    'Algeria': const LatLng(28.033886, 1.659626),
    'Angola': const LatLng(-11.202692, 17.873887),
    'Benin': const LatLng(9.30769, 2.315834),
    'Botswana': const LatLng(-22.328474, 24.684866),
    'Burkina Faso': const LatLng(12.238333, -1.561593),
    'Burundi': const LatLng(-3.373056, 29.918886),
    'Cameroon': const LatLng(7.369722, 12.354722),
    'Cape Verde': const LatLng(15.120142, -23.605172),
    'Central African Republic': const LatLng(6.611111, 20.939444),
    'Chad': const LatLng(15.454166, 18.732207),
    'Comoros': const LatLng(-11.875001, 43.872219),
    'Democratic Republic of the Congo': const LatLng(-4.038333, 21.758664),
    'Djibouti': const LatLng(11.825138, 42.590275),
    'Egypt': const LatLng(26.820553, 30.802498),
    'Equatorial Guinea': const LatLng(1.650801, 10.267895),
    'Eritrea': const LatLng(15.179384, 39.782334),
    'Eswatini (Swaziland)': const LatLng(-26.522503, 31.465866),
    'Ethiopia': const LatLng(9.145, 40.489673),
    'Gabon': const LatLng(-0.803689, 11.609444),
    'Gambia': const LatLng(13.443182, -15.310139),
    'Ghana': const LatLng(7.946527, -1.023194),
    'Guinea': const LatLng(9.945587, -9.696645),
    'Guinea-Bissau': const LatLng(11.803749, -15.180413),
    'Ivory Coast (Côte d\'Ivoire)': const LatLng(7.539989, -5.54708),
    'Kenya': const LatLng(-0.023559, 37.906193),
    'Lesotho': const LatLng(-29.609988, 28.233608),
    'Liberia': const LatLng(6.428055, -9.429499),
    'Libya': const LatLng(26.3351, 17.228331),
    'Madagascar': const LatLng(-18.766947, 46.869107),
    'Malawi': const LatLng(-13.254308, 34.301525),
    'Mali': const LatLng(17.570692, -3.996166),
    'Mauritania': const LatLng(21.00789, -10.940835),
    'Mauritius': const LatLng(-20.348404, 57.552152),
    'Morocco': const LatLng(31.791702, -7.09262),
    'Mozambique': const LatLng(-18.665695, 35.529562),
    'Namibia': const LatLng(-22.95764, 18.49041),
    'Niger': const LatLng(17.607789, 8.081666),
    'Nigeria': const LatLng(9.081999, 8.675277),
    'Rwanda': const LatLng(-1.940278, 29.873888),
    'Sao Tome and Principe': const LatLng(0.18636, 6.61308),
    'Senegal': const LatLng(14.497401, -14.452362),
    'Seychelles': const LatLng(-4.679574, 55.491977),
    'Sierra Leone': const LatLng(8.460555, -11.779889),
    'Somalia': const LatLng(5.152149, 46.199616),
    'South Africa': const LatLng(-30.559482, 22.937506),
    'South Sudan': const LatLng(6.876992, 31.306979),
    'Sudan': const LatLng(12.862807, 30.217636),
    'Tanzania': const LatLng(-6.369028, 34.888822),
    'Togo': const LatLng(8.619543, 0.824782),
    'Tunisia': const LatLng(33.886917, 9.537499),
    'Uganda': const LatLng(1.373333, 32.290275),
    'Zambia': const LatLng(-13.133897, 27.849332),
    'Zimbabwe': const LatLng(-19.015438, 29.154857),

    //Europe
    'Albania': const LatLng(41.153332, 20.168331),
    'Andorra': const LatLng(42.546245, 1.601554),
    'Austria': const LatLng(47.516231, 14.550072),
    'Belarus': const LatLng(53.709807, 27.953389),
    'Belgium': const LatLng(50.503887, 4.469936),
    'Bosnia and Herzegovina': const LatLng(43.915886, 17.679076),
    'Bulgaria': const LatLng(42.733883, 25.48583),
    'Croatia': const LatLng(45.1, 15.2),
    'Cyprus': const LatLng(35.126413, 33.429859),
    'Czech Republic': const LatLng(49.817492, 15.472962),
    'Denmark': const LatLng(56.26392, 9.501785),
    'Estonia': const LatLng(58.595272, 25.013607),
    'Finland': const LatLng(61.92411, 25.748151),
    'France': const LatLng(46.227638, 2.213749),
    'Germany': const LatLng(51.165691, 10.451526),
    'Greece': const LatLng(39.074208, 21.824312),
    'Hungary': const LatLng(47.162494, 19.503304),
    'Iceland': const LatLng(64.963051, -19.020835),
    'Ireland': const LatLng(53.41291, -8.24389),
    'Italy': const LatLng(41.87194, 12.56738),
    'Kosovo': const LatLng(42.602636, 20.902977),
    'Latvia': const LatLng(56.879635, 24.603189),
    'Liechtenstein': const LatLng(47.166, 9.555373),
    'Lithuania': const LatLng(55.169438, 23.881275),
    'Luxembourg': const LatLng(49.815273, 6.129583),
    'Malta': const LatLng(35.937496, 14.375416),
    'Moldova': const LatLng(47.411631, 28.369885),
    'Monaco': const LatLng(43.750298, 7.412841),
    'Montenegro': const LatLng(42.708678, 19.37439),
    'Netherlands': const LatLng(52.132633, 5.291266),
    'North Macedonia': const LatLng(41.608635, 21.745275),
    'Norway': const LatLng(60.472024, 8.468946),
    'Poland': const LatLng(51.919438, 19.145136),
    'Portugal': const LatLng(39.399872, -8.224454),
    'Romania': const LatLng(45.943161, 24.96676),
    'Russia': const LatLng(61.52401, 105.318756),
    'San Marino': const LatLng(43.94236, 12.457777),
    'Serbia': const LatLng(44.016521, 21.005859),
    'Slovakia': const LatLng(48.669026, 19.699024),
    'Slovenia': const LatLng(46.151241, 14.995463),
    'Spain': const LatLng(40.463667, -3.74922),
    'Armenia': const LatLng(40.069099, 45.038189),
    'Georgia': const LatLng(42.315407, 43.356892),
    'Greenland': const LatLng(71.706936, -42.604303),
    'Kazakhstan': const LatLng(48.019573, 66.923684),
    'Kyrgyzstan': const LatLng(41.20438, 74.766098),
    'Macedonia': const LatLng(41.608635, 21.745275),
    'Turkmenistan': const LatLng(38.969719, 59.556278),
    'Ukraine': const LatLng(48.379433, 31.16558),
    'Uzbekistan': const LatLng(41.377491, 64.585262),

    //Asia
    'Afghanistan': const LatLng(33.93911, 67.709953),
    'Bahrain': const LatLng(26.0667, 50.5577),
    'Bangladesh': const LatLng(23.685, 90.3563),
    'Bhutan': const LatLng(27.5142, 90.4336),
    'Brunei': const LatLng(4.5353, 114.7277),
    'Cambodia': const LatLng(12.5657, 104.991),
    'China': const LatLng(35.8617, 104.1954),
    'India': const LatLng(20.5937, 78.9629),
    'Indonesia': const LatLng(-0.7893, 113.9213),
    'Iran': const LatLng(32.4279, 53.688),
    'Iraq': const LatLng(33.2232, 43.6793),
    'Israel': const LatLng(31.0461, 34.8516),
    'Japan': const LatLng(36.2048, 138.2529),
    'Jordan': const LatLng(30.5852, 36.2384),
    'Kuwait': const LatLng(29.3117, 47.4818),
    'Laos': const LatLng(19.8563, 102.4955),
    'Lebanon': const LatLng(33.8547, 35.8623),
    'Thailand': const LatLng(15.870032, 100.992541),
    'South Korea': const LatLng(35.907757, 127.766922),
    'Vietnam': const LatLng(14.058324, 108.277199),
    'Oman': const LatLng(21.512583, 55.923255),
    'Pakistan': const LatLng(30.375321, 69.345116),
    'Palestine': const LatLng(31.952162, 35.233154),
    'Philippines': const LatLng(12.879721, 121.774017),
    'Qatar': const LatLng(25.354826, 51.183884),
    'Saudi Arabia': const LatLng(23.885942, 45.079162),
    'Singapore': const LatLng(1.352083, 103.819836),
    'Sri Lanka': const LatLng(7.873054, 80.771797),
    'Syria': const LatLng(34.802075, 38.996815),
    'Tajikistan': const LatLng(38.861034, 71.276093),
    'Turkey': const LatLng(38.963745, 35.243322),
    'United Arab Emirates': const LatLng(23.424076, 53.847818),
    'Azerbaijan': const LatLng(40.1431, 47.5769),
    'Maldives': const LatLng(3.2028, 73.2207),
    'Mongolia': const LatLng(46.8625, 103.8467),
    'Myanmar': const LatLng(21.9162, 95.956),
    'Nepal': const LatLng(28.3949, 84.124),
    'North Korea': const LatLng(40.3399, 127.5101),
    'Taiwan': const LatLng(23.6978, 120.9605),
    'Timor-Leste': const LatLng(-8.874217, 125.727539),

    //South - America
    'Argentina': const LatLng(-38.416097, -63.616672),
    'Brazil': const LatLng(-14.235004, -51.925280),
    'Colombia': const LatLng(4.570868, -74.297333),
    'Peru': const LatLng(-9.189967, -75.015152),
    'Chile': const LatLng(-35.675147, -71.542969),
    'Ecuador': const LatLng(-1.831239, -78.183406),
    'Uruguay': const LatLng(-32.522779, -55.765835),
    'Bolivia': const LatLng(-16.290154, -63.588653),
    'Guyana': const LatLng(4.860416, -58.93018),
    'Paraguay': const LatLng(-23.442503, -58.443832),
    'Suriname': const LatLng(3.919305, -56.027783),
    'Venezuela': const LatLng(6.42375, -66.58973),

    //North - America
    'Canada': const LatLng(56.130366, -106.346771),
    'United States': const LatLng(37.09024, -95.712891),
    'Mexico': const LatLng(23.634501, -102.552784),
    'Guatemala': const LatLng(15.783471, -90.230759),
    'Honduras': const LatLng(15.199999, -86.241905),
    'El Salvador': const LatLng(13.794185, -88.89653),
    'Nicaragua': const LatLng(12.865416, -85.207229),
    'Costa Rica': const LatLng(9.748917, -83.753428),
    'Panama': const LatLng(8.537981, -80.782127),
    'Belize': const LatLng(17.189877, -88.49765),
    'Bahamas': const LatLng(25.03428, -77.39628),
    'Cuba': const LatLng(21.521757, -77.781167),
    'Dominican Republic': const LatLng(18.735693, -70.162651),
    'Haiti': const LatLng(18.971187, -72.285215),
    'Jamaica': const LatLng(18.109581, -77.297508),
    'Puerto Rico': const LatLng(18.220833, -66.590149),
    'Trinidad and Tobago': const LatLng(10.691803, -61.222503),
    'Saint Kitts and Nevis': const LatLng(17.357822, -62.782998),
    'Saint Lucia': const LatLng(13.909444, -60.978893),
    'Saint Vincent and the Grenadines': const LatLng(13.252817, -61.197098),
    'Barbados': const LatLng(13.193887, -59.543198),
    'Grenada': const LatLng(12.262776, -61.604171),

    //Oceania
    'Australia': const LatLng(-25.274398, 133.775136),
    'Fiji': const LatLng(-17.713371, 178.065032),
    'Kiribati': const LatLng(-3.370417, -168.734039),
    'Marshall Islands': const LatLng(7.131474, 171.184478),
    'Micronesia': const LatLng(7.425554, 150.550812),
    'Nauru': const LatLng(-0.522778, 166.931503),
    'New Zealand': const LatLng(-40.900558, 174.885971),
    'Palau': const LatLng(7.514980, 134.582520),
    'Papua New Guinea': const LatLng(-6.314993, 143.955550),
    'Samoa': const LatLng(-13.759029, -172.104629),
    'Solomon Islands': const LatLng(-9.645710, 160.156194),
    'Tonga': const LatLng(-21.178986, -175.198242),
    'Tuvalu': const LatLng(-7.478269, 178.679413),
    'Vanuatu': const LatLng(-15.376706, 166.959158),

  };

  static LatLng? getCountryLatLng(String countryName){
    return _countryLocations[countryName];
  }

  static Map<String,LatLng> getAllCountries() {
    return _countryLocations;
  }

  static Future<String> getCountryFromLocation(LatLng location) async {
    try {
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placeMarks != null && placeMarks.isNotEmpty) {
        Placemark countryPlacemark = placeMarks.firstWhere((placeMark) => placeMark.country != null,);
        if (countryPlacemark != null) {
          return countryPlacemark.country!;
        }
      }
    } catch (e) {
      print('Error getting country from location: $e');
    }
    return 'No-country';
  }

}