// CodeExplorerExerciseGenerator
// Copyright (C) 2017-2023 CoderMerlin.Academy
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import XCTest
@testable import CodeExplorerExerciseGenerator

class PrimesTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPrimes() {
        // Test data
        let primes = [2, 3, 5, 7, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091,
                      1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213,
                      1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1297, 1301, 1303, 1307, 1319,
                      1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453,
                      1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567,
                      1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669,
                      1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801,
                      1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933,
                      1949, 1951, 1973, 1979, 1987, 1993, 1997, 1999, 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063,
                      2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131, 2137, 2141, 2143, 2153, 2161, 2179,
                      2203, 2207, 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287, 2293, 2297, 2309,
                      2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399, 2411, 2417,
                      2423, 2437, 2441, 2447, 2459, 2467, 2473]

        let nonPrimes = [-1, 0, 1, 4, 6, 10, 1000, 1001, 1002, 1004, 1005, 1006, 1008, 1010, 1012, 1014, 1015, 1016,
                         1018, 1020, 1022, 1024, 1025, 1026, 1028, 1030, 1032, 1034, 1035, 1036, 1038, 1040, 1042, 1044,
                         1045, 1046, 1048, 1050, 1052, 1054, 1055, 1056, 1058, 1060, 1062, 1064, 1065, 1066, 1068, 1070,
                         1071, 1072, 1074, 1075, 1076, 1078, 1080, 1082, 1084, 1085, 1086, 1088, 1090, 1092, 1094, 1095,
                         1096, 1098, 1100, 1102, 1104, 1105, 1106, 1108, 1110, 1112, 1114, 1115, 1116, 1118, 1120, 1122,
                         1124, 1125, 1126, 1128, 1130, 1132, 1134, 1135, 1136, 1138, 1140, 1142, 1144, 1145, 1146, 1148,
                         1150, 1152, 1154, 1155, 1156, 1158, 1160, 1162, 1164, 1165, 1166, 1168, 1170, 1172, 1174, 1175,
                         1176, 1178, 1180, 1182, 1184, 1185, 1186, 1188, 1190, 1192, 1194, 1195, 1196, 1198, 1200, 1202,
                         1204, 1205, 1206, 1208, 1210, 1212, 1214, 1215, 1216, 1218, 1220, 1222, 1224, 1225, 1226, 1228,
                         1230, 1232, 1234, 1235, 1236, 1238, 1240, 1242, 1244, 1245, 1246, 1248, 1250]

        let orderedPrimes: [Int] = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79,
                                     83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167,
                                     173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257,
                                     263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353,
                                     359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449,
                                     457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563,
                                     569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653,
                                     659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761,
                                     769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877,
                                     881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991,
                                     997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069 ]


        // isPrime 
        for prime in primes {
            XCTAssertTrue(Primes.isPrime(maybePrime: prime), "Expected isPrime(\(prime)) to be true.")
        }
        for nonPrime in nonPrimes {
            XCTAssertFalse(Primes.isPrime(maybePrime: nonPrime), "Expected isPrime(\(nonPrime)) to be false.")
        }

        XCTAssertNoThrow(try Primes.IsPrime.generate(exercise: .isPrime(repeatCount: 10, lowerBound: -1000, upperBound: 1000)))


        // nextPrime
        for index in 0 ..< orderedPrimes.count - 1 {
            let current = orderedPrimes[index]
            let next = orderedPrimes[index + 1]

            let actual = Primes.nextPrime(startingNumber: current)
            let expected = next 
            XCTAssertEqual(actual, expected, "Expected nextPrime(\(current)) to be \(expected), not \(actual).")
        }

        // previousPrime
        for index in 1 ..< orderedPrimes.count {
            let current = orderedPrimes[index]
            let previous = orderedPrimes[index - 1]

            let actual = Primes.previousPrime(startingNumber: current)
            let expected = previous
            XCTAssertNotNil(actual, "Expected nextPrime(\(current)) to be \(expected), not nil.")
            if let actual {
                XCTAssertEqual(actual, expected, "Expected nextPrime(\(current)) to be \(expected), not \(actual).")
            }
        }
        XCTAssertNil(Primes.previousPrime(startingNumber: 2))
        XCTAssertNil(Primes.previousPrime(startingNumber: 1))
        XCTAssertNil(Primes.previousPrime(startingNumber: 0))
        XCTAssertNil(Primes.previousPrime(startingNumber: -1000))
    }
    
}
