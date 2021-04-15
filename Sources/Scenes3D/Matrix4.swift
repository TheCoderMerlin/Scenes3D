/*
Scenes3D provides a Swift object library with support for 3D renderable entities.
Scenes3D runs on top of Scenes and IGIS.
Copyright (C) 2021 William Jackson, William Paroff, Camden Thomson,
                   CoderMerlin.com
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import Foundation

/// A `Matrix4` represents a 4x4 matrix of Doubles and provides supporting
/// functionality to handle 3D transforms.
public class Matrix4 : CustomStringConvertible {
    private var values : [[Double]] // Must be a 4x4 matrix

    /// The position attribute of this matrix.
    public var position : Vector3 {
        let x = values[0][3]
        let y = values[1][3]
        let z = values[2][3]
        return Vector3(x:x, y:y, z:z)
    }

    /// The identity 4x4 Matrix.
    public static let identity = Matrix4(values:[[1.0, 0.0, 0.0, 0.0],
                                                 [0.0, 1.0, 0.0, 0.0],
                                                 [0.0, 0.0, 1.0, 0.0],
                                                 [0.0, 0.0, 0.0, 1.0]])

    /// Creates a `Matrix4` from a 4x4 array of `Double`s.
    public init(values:[[Double]]) {
        precondition(values.count == 4, "values must be a 4x4 array")
        for row in values {
            precondition(row.count == 4, "values must be a 4x4 array")
        }
        self.values = values
    }

    public init(position:Vector3, quaternion:Quaternion, size:Vector3) {
        let x = quaternion.x
        let y = quaternion.y
        let z = quaternion.z
        let w = quaternion.w
        
        let x2 = x + x
        let y2 = y + y
        let z2 = z + z
        
        let xx = x * x2
        let xy = x * y2
        let xz = x * z2
        
        let yy = y * y2
        let yz = y * z2
        let zz = z * z2
        
        let wx = w * x2
        let wy = w * y2
        let wz = w * z2

        let sx = size.x
        let sy = size.y
        let sz = size.z

        values = []

        values.append([(1 - (yy + zz)) * sx,
                       (xy + wz) * sx,
                       (wz - wy) * sx,
                       0
                      ])

        values.append([(xy - wz) * sy,
                       (1 - (xx + zz)) * sy,
                       (yz + wx) * sy,
                       0
                      ])

        values.append([(xz + wy) * sz,
                       (yz - wx) * sz,
                       (1 - (xx + yy)) * sz,
                       0
                      ])

        values.append([position.x,
                       position.y,
                       position.z,
                       1
                      ])
    }
    
    public var description : String {
        // Convert to strings and pad all to uniform length
        let allValues : [Double] = Array<Double>(values.joined())
        let allStrings = allValues.map {"\($0)"}
        let longestCount = allStrings.reduce(0) {(result:Int, s:String) in max(s.count, result)}
        let paddingCount = longestCount + 2
        let paddedStrings = allStrings.map {$0.padding(toLength:paddingCount, withPad:" ", startingAt:0)}

        // Form the string
        var s = ""
        for row in 0..<4 {
            s += "[ "
            for column in 0..<4 {
                s += paddedStrings[row * 4 + column]
            }
            s += "]\n"
        }

        return s
    }

    /// Returns the specified row from the `Matrix4`.
    public func row(_ rowIndex:Int) -> [Double] {
        precondition((0..<4).contains(rowIndex), "Expected index in range 0..<4")
        return values[rowIndex]
    }

    /// Returns the specified column from the `Matrix4`.
    public func column(_ columnIndex:Int) -> [Double] {
        precondition((0..<4).contains(columnIndex), "Expected index in range 0..<4")
        var vector = [Double]()
        for rowIndex in 0..<4 {
            vector.append(values[rowIndex][columnIndex])
        }

        return vector
    }

    /// Returns the value at the specified row and column index.
    public func value(_ rowIndex:Int, _ columnIndex:Int) -> Double {
        precondition((0..<4).contains(rowIndex), "Expected index in range 0..<4")
        precondition((0..<4).contains(columnIndex), "Expected index in range 0..<4")
        return values[rowIndex][columnIndex]
    }
}
