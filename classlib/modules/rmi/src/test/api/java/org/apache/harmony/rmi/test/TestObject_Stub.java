/*
 * RMI stub class
 * for class org.apache.harmony.rmi.test.TestObject
 * Compatible with stub protocol version 1.2
 *
 * Generated by DRL RMI Compiler (rmic).
 *
 * DO NOT EDIT!!!
 * Contents subject to change without notice!
 */
package org.apache.harmony.rmi.test;


public final class TestObject_Stub extends java.rmi.server.RemoteStub
        implements org.apache.harmony.rmi.test.MyRemoteInterface1, org.apache.harmony.rmi.test.TestInterface {

    private static final long serialVersionUID = 2;

    private static java.lang.reflect.Method $method_runRemote_0;
    private static java.lang.reflect.Method $method_test1_1;

    static {
        try {
            $method_runRemote_0 = org.apache.harmony.rmi.test.TestInterface.class.getMethod("runRemote", new java.lang.Class[] {java.rmi.Remote.class});
            $method_test1_1 = org.apache.harmony.rmi.test.MyRemoteInterface1.class.getMethod("test1", new java.lang.Class[] {});
        } catch (java.lang.NoSuchMethodException e) {
            throw new java.lang.NoSuchMethodError(
                    "Stub class initialization failed: org.apache.harmony.rmi.test.TestObject_Stub");
        }
    }

    public TestObject_Stub(java.rmi.server.RemoteRef ref) {
        super(ref);
    }

    // Implementation of runRemote(Remote)
    public void runRemote(java.rmi.Remote $param_Remote_1)
            throws java.rmi.RemoteException {
        try {
            ref.invoke(this, $method_runRemote_0, new java.lang.Object[] {$param_Remote_1}, -3789895345284725521L);
        } catch (java.lang.RuntimeException e) {
            throw e;
        } catch (java.rmi.RemoteException e) {
            throw e;
        } catch (java.lang.Exception e) {
            throw new java.rmi.UnexpectedException("Undeclared checked exception", e);
        }
    }

    // Implementation of test1()
    public java.lang.String test1()
            throws java.rmi.RemoteException {
        try {
            java.lang.Object $result = ref.invoke(this, $method_test1_1, null, -52386119061268754L);
            return ((java.lang.String) $result);
        } catch (java.lang.RuntimeException e) {
            throw e;
        } catch (java.rmi.RemoteException e) {
            throw e;
        } catch (java.lang.Exception e) {
            throw new java.rmi.UnexpectedException("Undeclared checked exception", e);
        }
    }
}