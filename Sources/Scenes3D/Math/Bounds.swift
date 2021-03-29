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

public struct Bounds : Equatable {
    public var position : Vector3
    public var size : Vector3

    static public var zero = Bounds()

    public init(position:Vector3 = Vector3.zero, size:Vector3 = Vector3.one) {
        self.position = position
        self.size = size
    }

    static public func == (left:Bounds, right:Bounds) -> Bool {
        return left.position == right.position && left.size == right.size
    }
}
