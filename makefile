PROGRAM = gitty
INSTALL_DIR = /usr/local/bin

all: build

build:
   nimble build -d:ssl -d:release



.PHONY
