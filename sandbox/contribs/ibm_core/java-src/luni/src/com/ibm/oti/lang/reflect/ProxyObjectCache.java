/* Copyright 2001, 2005 The Apache Software Foundation or its licensors, as applicable
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.ibm.oti.lang.reflect;


class ProxyObjectCache {
	Object keyTable[];

	int valueTable[];

	int elementSize;

	int threshold;

	ProxyObjectCache(int initialCapacity) {
		if (initialCapacity < 13)
			initialCapacity = 13;
		this.elementSize = 0;
		this.threshold = (int) (initialCapacity * 0.66f);
		this.keyTable = new Object[initialCapacity];
		this.valueTable = new int[initialCapacity];
	}

	int get(Object key) {
		int index = hashCode(key);
		while (keyTable[index] != null) {
			if (keyTable[index].equals(key))
				return valueTable[index];
			index = (index + 1) % keyTable.length;
		}
		return -1;
	}

	int hashCode(Object key) {
		return (key.hashCode() & 0x7FFFFFFF) % keyTable.length;
	}

	int put(Object key, int value) {
		int index = hashCode(key);
		while (keyTable[index] != null) {
			if (keyTable[index].equals(key))
				return valueTable[index] = value;
			index = (index + 1) % keyTable.length;
		}
		keyTable[index] = key;
		valueTable[index] = value;

		// assumes the threshold is never equal to the size of the table
		if (++elementSize > threshold)
			rehash();
		return value;
	}

	private void rehash() {
		ProxyObjectCache newHashtable = new ProxyObjectCache(
				keyTable.length * 2);
		for (int i = keyTable.length; --i >= 0;)
			if (keyTable[i] != null)
				newHashtable.put(keyTable[i], valueTable[i]);

		this.keyTable = newHashtable.keyTable;
		this.valueTable = newHashtable.valueTable;
		this.threshold = newHashtable.threshold;
	}

	int size() {
		return elementSize;
	}

	public String toString() {
		int max = size();
		StringBuffer buf = new StringBuffer();
		buf.append("{");
		for (int i = 0; i < max; ++i) {
			if (keyTable[i] != null)
				buf.append(keyTable[i]).append("->").append(valueTable[i]);
			if (i < max)
				buf.append(", ");
		}
		buf.append("}");
		return buf.toString();
	}
}