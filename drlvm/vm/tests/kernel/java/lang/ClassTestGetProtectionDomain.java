/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

/**
 * @author Evgueni V. Brevnov, Roman S. Bushmanov
 */
package java.lang;

import java.security.AllPermission;
import java.security.ProtectionDomain;

import junit.framework.TestCase;

/**
 * tested class: java.lang.Class
 * tested method: getProtectionDomain
 */
public class ClassTestGetProtectionDomain extends TestCase {

    /**
     * Checks protection domain for the class which was loaded by bootstrap
     * class loader.
     */
    public void test1() {
        ProtectionDomain pd = Object.class.getProtectionDomain();
        assertNotNull("unexpected null", pd);
        assertNull("null expected", pd.getCodeSource());
        assertTrue("AllPermission expected", 
                pd.getPermissions().implies(new AllPermission()));
    }

    /**
     * Checks that protection domain is not null.
     */
    public void test2() {
        ProtectionDomain pd = getClass().getProtectionDomain();
        assertNotNull("unexpected null", pd);
        assertNull("null expected", pd.getCodeSource());
    }
}