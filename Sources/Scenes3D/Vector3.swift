/*
Scenes3D provides a Swift object library with support for 3D renderable entities.
Scenes3D runs on top of Scenes and IGIS.
Copyright (C) 2021 William Jackson, William Paroff, Camden Thomson,
                   Tango Golf Digital, LLC
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

public struct Vector3 {
    public var x : Int
    public var y : Int
    public var z : Int

    static public let zero = Vector3(x:0, y:0, z:0)

    public init() {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    public init(x:Int, y:Int, z:Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}
