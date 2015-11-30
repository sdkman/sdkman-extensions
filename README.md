# SDKMAN Extension Commands

SDKMAN is the The Software Development Kit Manager. It is a tool for managing parallel Versions of multiple Software Development Kits on any Unix based system. It provides a convenient command line interface for installing, switching, removing and listing Candidates. Documentation can be found on the [GVM Project Page](http://gvmtool.net).

## Extension Commands

SDKMAN allows you to add your own extension commands. An extension command is picked up by GVM based on the following naming convention:

    sdkman-<command> <arg1> [argz]

The extensions should then define a function containing the name of the new command as follows:

	function __sdkman_<command> {
		//code
	}

Any such custom extensions must be placed in the `ext` folder under your GVM directory (usually `~/.sdkman`).

This may then be invoked from the command line by:

    sdk command arg1 [argz]

where:
* command : the custom extension's name
* arg1 : the candidate (mandatory)
* argz : additional optional parameter(s)

Example:

    sdk switch grails


To install all the commands in this project into `SDKMAN_DIR`:

    gradle install
