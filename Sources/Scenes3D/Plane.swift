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

/// A `Plane` represents a 2-dimensional surface that extends infinitely in
/// 3D space.  It is represented in Hessian normal form.
internal struct Plane {
    var normal : Vector3
    var constant : Double

    init(normal:Vector3, constant:Double) {
        self.normal = normal
        self.constant = constant
    }

    func distanceToPoint(_ point:Vector3) -> Double {
        return normal.dotProduct(with:point) + constant
    }
}
