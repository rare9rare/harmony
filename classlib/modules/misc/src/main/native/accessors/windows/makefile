#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

HY_BIN=$(HY_TARGET)\build\classlib\misc\native\accessors\# trailing slash
!include <$(HY_TARGET)\hdk\build\make\defines.mak>

LIBBASE=accessors
DLLNAME=$(DLLPATH)$(LIBBASE).dll
LIBNAME=$(LIBPATH)$(LIBBASE).lib
HYLDFLAGS = $(HYLDFLAGS) -def:$(LIBBASE).def

BUILDFILES = \
  $(HY_BIN)org_apache_harmony_misc_accessors_ArrayAccessorImpl.obj \
  $(HY_BIN)org_apache_harmony_misc_accessors_Malloc.obj \
  $(HY_BIN)org_apache_harmony_misc_accessors_MemoryAccessorNativeImpl.obj \
  $(HY_BIN)org_apache_harmony_misc_accessors_ObjectAccessorImpl.obj \
  $(HY_BIN)org_apache_harmony_misc_accessors_StringAccessorImpl.obj
VIRTFILES = accessors.res
SYSLIBFILES = ws2_32.lib Iphlpapi.lib

DLLBASE=0x13300000

!include <$(HY_HDK)\build\make\rules.mak>
