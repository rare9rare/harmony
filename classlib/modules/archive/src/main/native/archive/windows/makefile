# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# Makefile for module 'archive'
#

HY_BIN=$(HY_TARGET)\build\classlib\archive\native\archive\# trailing slash
!include <$(HY_TARGET)\hdk\build\make\defines.mak>

LIBBASE=hyarchive
DLLNAME=$(DLLPATH)$(LIBBASE).dll
LIBNAME=$(LIBPATH)$(LIBBASE).lib
HYCFLAGS = $(HYCFLAGS) /I$(SHAREDSUB) /I$(SHARED)common /I..\..\zlib_dist \
	   /I..\..\include\shared
HYLDFLAGS = $(HYLDFLAGS) -def:$(LIBBASE).def

BUILDFILES = \
	$(HY_BIN)archive_copyright.obj $(HY_BIN)jclcrc32.obj \
	$(HY_BIN)zip.obj $(HY_BIN)adler32.obj $(HY_BIN)inflater.obj \
	$(HY_BIN)jarfile.obj $(HY_BIN)deflater.obj $(HY_BIN)archiveglob.obj

VIRTFILES = $(LIBBASE).res

SYSLIBFILES = ws2_32.lib Iphlpapi.lib

!IF "$(HY_ZIP_API)" != "true"
MDLLIBFILES = $(MDLLIBFILES) $(LIBPATH)hyzip$(HY_LINKLIB_SUFFIX)
!ENDIF

MDLLIBFILES = $(MDLLIBFILES) \
        $(LIBPATH)hyzlib$(HY_LINKLIB_SUFFIX) \
	$(LIBPATH)vmi$(HY_LINKLIB_SUFFIX)
DLLBASE=0x13100000

!include <$(HY_HDK)\build\make\rules.mak>
