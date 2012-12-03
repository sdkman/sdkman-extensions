# GVM Extension Commands

GVM is the Groovy enVironment Manager. It is a tool for managing parallel Versions of multiple Software Development Kits on any Unix based system. It provides a convenient command line interface for installing, switching, removing and listing Candidates. Documentation can be found on the [GVM Project Page](http://gvmtool.net).

## Extension Commands

GVM allows you to add your own extension commands. An extension command is picked up by GVM based on the following naming convention:

    gvm-<command> <arg1> [argz]

Any such custom extensions must be placed in the `ext` folder under your GVM directory (usually `~/.gvm`).

This may then be invoked from the command line by:

    gvm command arg1 [argz]

where:
	command : the custom extension's name
	arg1    : the candidate (mandatory)
	argz    : additional optional parameter(s)

Example:

    gvm switch grails


To install all the commands in this project:

    gradle install
