
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <pwd.h>
#include <fcntl.h>
#include <signal.h>

#include "main.h"
#include "conf.h"
#include "log.h"
#include "unix.h"


void unix_sig_stop( int signo ) {
	if( gconf->is_running == 0 ) {
		exit( 1 );
	}

	gconf->is_running = 0;
	log_info( "Shutting down..." );
}

void unix_sig_term( int signo ) {
	if( gconf->is_running == 0 ) {
		exit( 1 );
	}

	gconf->is_running = 0;
}

void unix_signals( void ) {
	struct sigaction sig_stop;
	struct sigaction sig_term;

	// STRG+C aka SIGINT => Stop the program
	sig_stop.sa_handler = unix_sig_stop;
	sig_stop.sa_flags = 0;
	if( ( sigemptyset( &sig_stop.sa_mask ) == -1) || (sigaction( SIGINT, &sig_stop, NULL ) != 0) ) {
		log_err( "UNX: Failed to set SIGINT to handle Ctrl-C" );
		exit( 1 );
	}

	// SIGTERM => Stop the program gracefully
	sig_term.sa_handler = unix_sig_term;
	sig_term.sa_flags = 0;
	if( ( sigemptyset( &sig_term.sa_mask ) == -1) || (sigaction( SIGTERM, &sig_term, NULL ) != 0) ) {
		log_err( "UNX: Failed to set SIGTERM to handle Ctrl-C" );
		exit( 1 );
	}
}

void unix_fork( void ) {
	pid_t pid;
	pid_t sid;

	pid = fork();

	if( pid < 0 ) {
		log_err( "UNX: Failed to fork." );
		exit( 1 );
	} else if( pid != 0 ) {
		// Child process
		exit( 0 );
	}

	// Become session leader
	sid = setsid();
	if( sid < 0 ) {
		exit( 1 );
	}

	// Clear out the file mode creation mask
	umask( 0 );
}

void unix_write_pidfile( int pid, const char* pidfile ) {
	FILE *file;

	file = fopen( pidfile, "r" );
	if( file ) {
		fclose( file );
		log_err( "UNX: PID file already exists: %s", pidfile );
		exit( 1 );
	}

	file = fopen( pidfile, "w" );
	if( file == NULL ) {
		log_err( "UNX: Failed to open PID file." );
		exit( 1 );
	}

	if( fprintf( file, "%i\n", pid ) < 0 ) {
		log_err( "UNX: Failed to write PID file." );
		exit( 1 );
	}

	if( fclose( file ) < 0 ) {
		log_err( "UNX: Failed to close PID file." );
		exit( 1 );
	}
}

void unix_dropuid0( void ) {
	struct passwd *pw;

	// Return if no user is set
	if( gconf->user == NULL ) {
		return;
	}

	// Return if we are not root
	if( getuid() != 0 ) {
		return;
	}

	// Process is running as root, drop privileges
	if( (pw = getpwnam( gconf->user )) == NULL ) {
		log_err( "UNX: Dropping uid 0 failed. Set a valid user." );
		exit( 1 );
	}

	if( setenv( "HOME", pw->pw_dir, 1 ) != 0 ) {
		log_err( "UNX: Setting new $HOME failed." );
		exit( 1 );
	}

	if( setgid( pw->pw_gid ) != 0 ) {
		log_err( "UNX: Unable to drop group privileges" );
		exit( 1 );
	}

	if( setuid( pw->pw_uid ) != 0 ) {
		log_err( "UNX: Unable to drop user privileges" );
		exit( 1 );
	}

	// Test permissions
	if( setuid( 0 ) != -1 || setgid( 0 ) != -1 ) {
		log_err( "UNX: We still have root privileges" );
		exit( 1 );
	}
}
