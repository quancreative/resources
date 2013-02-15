/*
 * BetweenAS3
 * 
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 BeInteractive! (www.be-interactive.org) and
 *                    Spark project  (www.libspark.org)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */
package org.libspark.betweenas3.filters
{
	// Tweener で言う SpecialProeprtySplitter のようなもの。
	// トゥイーンのパラメータをフィルタリングして正規化などを行う
	
	// たとえば
	// 
	// target = MovieClip
	// to = {frame: 'hoge'}
	//
	// が渡ってきた場合、MovieClipFrameLabelFilter は
	// target からフレームラベル「hoge」のフレームの位置を取得して
	//
	// to = {frame:3}
	//
	// に変更するなど。
	
	/**
	 * トゥイーンのパラメータフィルタ.
	 * 
	 * @author	yossy:beinteractive
	 */
	public interface IParameterFilter
	{
		/**
		 * フィルタ処理を行います.
		 * 
		 * @param	target	フィルタ対象となるターゲット
		 * @param	to	フィルタ対象となるパラメータ (開始値)
		 * @param	from	フィルタ対象となるパラメータ (終了値)
		 * @param	args	フィルタ対象となるパラメータ (そのほか)
		 */
		function filter(target:Object, to:Object, from:Object, args:Object):void;
	}
}