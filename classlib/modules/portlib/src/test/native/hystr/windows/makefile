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

#
# Makefile for module 'hystr.exe'
#

!include <$(HY_HDK)\build\make\defines.mak>

EXENAME=..\hystr.exe
HYCFLAGS = $(HYCFLAGS) /I$(SHAREDSUB) /I..\..\hycunit

BUILDFILES = $(SHAREDSUB)hystr.obj
BUILDFILES = $(BUILDFILES) ..\..\hycunit\hycunit.obj
MDLLIBFILES = $(MDLLIBFILES) $(LIBPATH)hyprt$(HY_LINKLIB_SUFFIX)

!IF "$(HY_NO_THR)" == "true"
MDLLIBFILES = $(MDLLIBFILES) $(LIBPATH)hythr$(HY_LINKLIB_SUFFIX)
!ENDIF

EXEFLAGS=$(conlflags) -subsystem:console
EXEDLLFILES=$(conlibsdll)
CLEANFILES=..\TEST-*.xml

!include <$(HY_HDK)\build\make\rules.mak>
