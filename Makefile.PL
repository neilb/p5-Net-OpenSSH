use 5.008;
use ExtUtils::MakeMaker;

$^O =~ /Win32/ and die "This module does not work on MS Windows.\nTry installing a real OS!\n";

my $ssh_V = `ssh -V 2>&1`;
if (defined $ssh_V) {
    chomp $ssh_V;
    if (my ($ver, $rev) = $ssh_V =~ /^openssh_(\d+)\.(\d+)/i) {
	if ($ver < 4 or ($ver == 4 and $rev < 1)) {
	    warn <<EOW;
The OpenSSH client I have found in the PATH is too old ($ver.$rev)!
Version 4.1 is required and 5.2 recommended.
Continuing anyway...
EOW
	}
    }
    else {
	warn <<EOW;
The SSH client I have found in the PATH does not seem to be OpenSSH!
SSH client version: $ssh_V
Continuing anyway...
EOW
    }
}
else {
    warn <<EOW;
No SSH client is available from your PATH!
Continuing anyway...
EOW
}

WriteMakefile( NAME => 'Net::OpenSSH',
               VERSION_FROM => 'lib/Net/OpenSSH.pm',
               ABSTRACT_FROM => 'lib/Net/OpenSSH.pm',
               PREREQ_PM => { Test::More => 0, },
               AUTHOR => 'Salvador Fandino <sfandino@yahoo.com>' );
