﻿package pdh.math{		public class Angle	{				public static function actualAngle(oldAngle:Number, newAngle:Number):Number		{			var distanceNormal:Number = Math.abs(oldAngle - newAngle);			var distanceForward:Number = Math.abs(oldAngle - (newAngle + 360));			var distanceBackward:Number = Math.abs(oldAngle - (newAngle - 360));			var actualNewAngle:Number;			if (Math.min(distanceNormal, Math.min(distanceForward, distanceBackward)) == distanceForward) {				actualNewAngle = newAngle + 360;			} else if (Math.min(distanceNormal, Math.min(distanceForward, distanceBackward)) == distanceBackward) {				actualNewAngle = newAngle - 360;			} else {				actualNewAngle = newAngle;			}			return actualNewAngle;					}				// convert angle to range of 360 and positive		public static function normalizeFromZero(val:Number):Number 		{			var compareValue:Number = val;			compareValue %= 360;							if (compareValue < 0){				compareValue = 360 + compareValue;			}			if (compareValue == 360){				compareValue = 0;			}			return compareValue;		}				public static function deg2rad(degree:Number) 		{    		 return degree * (Math.PI / 180);		}		} // end class	}  // end package