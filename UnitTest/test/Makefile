
GTEST_DIR = ../gtest
CXX = g++
CC = gcc
USER_DIR = .
MAIN_DIR = ../../
CPPFLAGS += -isystem $(GTEST_DIR)/include 
CXXFLAGS += -g -Wall -Wextra -pthread
CXXFLAGS_LCOV += -g -Wall -Wextra -pthread -fprofile-arcs -ftest-coverage
TARGET = runTest
LINK_LIB = -L$(MAIN_DIR)/lib
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
		$(GTEST_DIR)/include/gtest/internal/*.h

all : $(TARGET)

GTEST_SRCS = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

gtest-all.o : $(GTEST_SRCS)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -c \
		$(GTEST_DIR)/src/gtest-all.cc
gtest_main.o : $(GTEST_SRCS)
	$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -c \
		$(GTEST_DIR)/src/gtest_main.cc
gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

CXX_SOURCES = $(wildcard $(MAIN_DIR)/source/src/*.cpp)
CC_SOURCES = $(wildcard $(MAIN_DIR)/source/src/*.c)
TEST_CASE_SOURCES = $(wildcard $(USER_DIR)/*.cpp)
CXX_OBJS = $(patsubst %.cpp, %.o, $(CXX_SOURCES))
CC_OBJS = $(patsubst %.c, %.o, $(CC_SOURCES))
TEST_CASE_OBJS = $(patsubst %.cpp, %.o, $(TEST_CASE_SOURCES))
INCLUDE_DIR = -I$(MAIN_DIR)/source/include

$(TEST_CASE_OBJS) : %.o : %.cpp
	$(CXX) $(CPPFLAGS) -c $< -o $@ $(INCLUDE_DIR)

$(CXX_OBJS) : %.o : %.cpp
	$(CXX) $(CXXFLAGS_LCOV) -c $< -o $@ $(INCLUDE_DIR)

$(CC_OBJS) : %.o : %.c
	$(CC) $(CXXFLAGS_LCOV) -c $< -o $@ $(INCLUDE_DIR)

$(TARGET) : $(CXX_OBJS) $(CC_OBJS) $(TEST_CASE_OBJS) gtest_main.a
	$(CXX) $(CXXFLAGS_LCOV) $^ -o $@ $(LINK_LIB)

SUBDIRS = $(USER_DIR) $(MAIN_DIR)/source/src

GCDA_FILES = $(foreach dir, $(SUBDIRS), $(wildcard $(dir)/*.gcda))
GCNO_FILES = $(foreach dir, $(SUBDIRS), $(wildcard $(dir)/*.gcno))
OBJS_FILES = $(foreach dir, $(SUBDIRS), $(wildcard $(dir)/*.o))

clean :
	rm -fr $(TARGET) gtest_main.a *.o *.gcno *.gcda *.info lcov_output/* \
		$(GCDA_FILES) $(GCNO_FILES) $(OBJS_FILES)



