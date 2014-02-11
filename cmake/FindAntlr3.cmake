############################################################################
# FindAntlr3.txt
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################
#
# - Find the antlr3c include file and library and antlr.jar
#
#  ANTLR3C_FOUND - system has antlr3c
#  ANTLR3C_INCLUDE_DIR - the antlr3c include directory
#  ANTLR3C_LIBRARIES - The libraries needed to use antlr3c
#  ANTLR3_JAR_FOUND - sytem has antlr.jar
#  ANTLR3_JAR_PATH - the antlr.jar path

include(CMakePushCheckState)
include(CheckIncludeFile)
include(CheckFunctionExists)

set(_ANTLR3C_ROOT_PATHS
	${WITH_ANTLR}
	${CMAKE_INSTALL_PREFIX}
)
if(WIN32)
	set(_ANTLR3_JAR_ROOT_PATHS
		${WITH_ANTLR}
		${CMAKE_INSTALL_PREFIX}
	)
else(WIN32)
	set(_ANTLR3_JAR_ROOT_PATHS
		${WITH_ANTLR}
		${CMAKE_INSTALL_PREFIX}
		/usr/local
		/usr
		/opt/local
	)
endif(WIN32)


find_path(ANTLR3C_INCLUDE_DIR
	NAMES antlr3.h
	HINTS _ANTLR3C_ROOT_PATHS
	PATH_SUFFIXES include
)
if(NOT "${ANTLR3C_INCLUDE_DIR}" STREQUAL "")
	set(HAVE_ANTLR3_H 1)

	find_library(ANTLR3C_LIBRARIES
		NAMES antlr3c
		HINTS _ANTLR3C_ROOT_PATHS
		PATH_SUFFIXES bin lib
	)

	if(NOT "${ANTLR3C_LIBRARIES}" STREQUAL "")
		set(ANTLR3C_FOUND TRUE)

		cmake_push_check_state(RESET)
		set(CMAKE_REQUIRED_INCLUDES ${ANTLR3C_INCLUDE_DIR})
		set(CMAKE_REQUIRED_LIBRARIES ${ANTLR3C_LIBRARIES})
		check_function_exists("antlr3StringStreamNew" HAVE_ANTLR_STRING_STREAM_NEW)
		cmake_pop_check_state()
	endif(NOT "${ANTLR3C_LIBRARIES}" STREQUAL "")
endif(NOT "${ANTLR3C_INCLUDE_DIR}" STREQUAL "")

mark_as_advanced(ANTLR3C_INCLUDE_DIR ANTLR3C_LIBRARIES)


find_file(ANTLR3_JAR_PATH
	NAMES antlr.jar antlr3.jar
	HINTS _ANTLR3_JAR_ROOT_PATHS
	PATH_SUFFIXES share/java
)

if(NOT "${ANTLR3_JAR_PATH}" STREQUAL "")
	set(ANTLR3_JAR_FOUND TRUE)
endif(NOT "${ANTLR3_JAR_PATH}" STREQUAL "")

mark_as_advanced(ANTLR3_JAR_PATH)