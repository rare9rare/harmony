#!/bin/sh
#
#!
# @file ./dist-bin.sh
#
# @brief Distribute Boot JVM binary package, including documentation.
#
# Make @e sure to have performed the final build by running
# @link ./clean.sh clean.sh all@endlink followed by
# @link ./build.sh build.sh all@endlink.  This will guarantee
# that everything compiles clean and may be installed and
# run on all platforms of this CPU type.
#
# Use @link ./dist-src.sh dist-src.sh@endlink to distribute
# the source package.
#
# Use @link ./dist-doc.sh dist-doc.sh@endlink to distribute
# the documentation package.
#
# @see @link ./common.sh ./common.sh@endlink
#
# @attention  Make @e sure that all Eclipse project files are in
#             the "open" state when creating a distribution.
#             This will ensure immediate access to them by
#             Eclipse users without having to change anything.
#
# @todo This script should probably support each and every CPU platform
#       that implements this code instad of having just a single
#       output location for each file.  However, that also involves
#       changes to @link ./build.sh build.sh@endlink and
#       @link ./clean.sh clean.sh@endlink and
#       @link ./common.sh common.sh@endlink, as well as
#       @link ./config.sh config.sh@endlink.  This is left as an
#       exercise for the project team.  For an example of such a
#       multi-host script, consider that the original development was
#       done on a Solaris platform.  Such distribution should be built
#       using @link ./clean.sh ./clean.sh all@endlink followed by
#       @link ./build.sh ./build.sh all@endlink and should contain
#       all formats of documentation.  If no CPU-specific directory
#       level were implemented, result should look like the current
#       distribution:
#
# <ul>
#
#       <li>jvm/bin/bootjvm</li>
#       <li>libjvm/lib/libjvm.a</li>
#       <li>main/bin/bootjvm</li>
#       <li>test/bin/HelloWorld.class</li>
#       <li>test/bin/harmony/bootjvm/test/MainArgs.class</li>
#       <li>test/bin/harmony/bootjvm/test/PkgHelloWorld.class</li>
#       <li>doc/html/...</li>
#       <li>doc/latex/...</li>
#       <li>doc/rtf/...</li>
#       <li>doc/man/man3/...</li>
#       <li>doc/xml/...</li>
# </ul>
#
# A CPU-specific directory would use the @b CONFIG_@$OSNAME@$WORDWIDTH
# configuration variable to change the target name to,
#
# <ul>
#       <li>jvm/bin/@${CONFIG_@$OSNAME@$WORDWIDTH}/bootjvm</li>
# </ul>
#
# Namely,
#
# <ul>
#       <li>jvm/bin/solaris32/bootjvm</li>
#       <li>jvm/bin/solaris64/bootjvm</li>
#       <li>jvm/bin/linux32/bootjvm</li>
#       <li>jvm/bin/linux64/bootjvm</li>
#       <li>jvm/bin/windows32/bootjvm</li>
#       <li>jvm/bin/windows64/bootjvm</li>
#       <li>jvm/bin/linux64/bootjvm</li>
# </ul>
#
# and so forth for the other deliverables.
#
#
# @todo A Windows .BAT version of this script needs to be written
#
#
# @section Control
#
# \$URL$ \$Id$
#
# Copyright 2005 The Apache Software Foundation
# or its licensors, as applicable.
#
# Licensed under the Apache License, Version 2.0 ("the License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied.
#
# See the License for the specific language governing permissions
# and limitations under the License.
#
# @version \$LastChangedRevision$
#
# @date \$LastChangedDate$
#
# @author \$LastChangedBy$
#         Original code contributed by Daniel Lydick on 09/28/2005.
#
# @section Reference
#
#/ /* 
# (Use  #! and #/ with dox_filter.sh to fool Doxygen into
# parsing this non-source text file for the documentation set.
# Use the above open comment to force termination of parsing
# since it is not a Doxygen-style 'C' comment.)
#
#
###################################################################
#
# Script setup.
#
. echotest.sh

. common.sh

MSG80="This script must NOT be interrupted.  Last chance to stop it..."
$echon "$PGMNAME:  $MSG80" $echoc
sleep 5
echo ""
echo ""

# Suppress attempts to interrupt
trap "" 1 2 3 15

###################################################################
#
# Clean up everything and rebuild it.
#
./clean.sh all

DistPrep

DistDocPrep

DistTargetBuild all

DistConfigPrep

echo ""
echo "$PGMNAME: Setting target directory permissions"
umask 022
chmod 0755 `find . -type d -print`

# Use same target as source distribution for original docs,
# that is, they will _not_ be changed.
if test -d doc.ORIG
then
    chmod -R +w doc.ORIG
    rm -rf doc.ORIG
fi

./doxunpatch.sh

mv doc doc.ORIG

TARGET_HOME="harmony/bootJVM-$CONFIG_RELEASE_LEVEL"
cd ../..
mv harmony/bootJVM $TARGET_HOME

TARGET_FILELIST="$TARGET_HOME/jvm/bin/bootjvm \
                 $TARGET_HOME/libjvm/lib/libjvm.a \
                 $TARGET_HOME/main/bin/bootjvm \
                 $TARGET_HOME/jni/src/harmony/generic/0.0/bin/bootjvm"

TARGET_DIRLIST="$TARGET_HOME/test/bin \
                $TARGET_HOME/doc.ORIG"

echo ""
echo "$PGMNAME: Setting target file permissions"
chmod 0644 $TARGET_FILELIST

TARGET_DIRFILELIST="`find $TARGET_HOME/test/bin -print`; \
                    `find $TARGET_HOME/doc.ORIG -print`"

# Time stamp all files together
TMPTIMESTAMPFILE=${TMPDIR:-/tmp}/tmp.$PGMNAME.$$
rm -f $TMPTIMESTAMPFILE
touch TMPTIMESTAMPFILE
for f in $TARGET_FILELIST $TARGET_DIRFILELIST
do
    chmod +w $f
    touch -r TMPTIMESTAMPFILE $f
    chmod -w $f
done
rm -f $TMPTIMESTAMPFILE

echo ""
echo "$PGMNAME: Creating distribution file '../../$DISTBINTAR'"

rm -f $DISTBINTAR
tar cf $DISTBINTAR $TARGET_FILELIST $TARGET_DIRLIST
mv $TARGET_HOME harmony/bootJVM

if test ! -r $DISTBINTAR
then
    echo ""
    echo "$PGMNAME: Directory `cd ../..; pwd` is not writable."
    echo "$PGMNAME: Please make it writable and try again."
    exit 4
fi

echo ""
echo \
   "$PGMNAME: Compressing distribution file into '../../$DISTBINTAR.gz'"
rm -f $DISTBINTAR.gz
gzip $DISTBINTAR
if test ! -r $DISTBINTAR.gz
then
    echo ""
    echo "$PGMNAME: Cannot compress into '$DISTBINTAR.gz'"
    exit 5
fi

chmod 0444 $DISTBINTAR.gz
cd harmony/bootJVM

chmod -R +w doc.ORIG
mv doc.ORIG doc

DistConfigUnPrep

DistDocUnPrep

DistUnPrep

echo ""
echo "$PGMNAME: Binary distribution tar file created:"
echo ""
ls -l ../../$DISTBINTAR.gz
echo ""

###################################################################
#
# Done.
#
echo ""
echo "$PGMNAME: Binary distribution complete"

#
# EOF