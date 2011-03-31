#line 1
package IO::Interactive;

use version; $VERSION = qv('0.0.6');

use warnings;
use strict;
use Carp;
use Scalar::Util qw( openhandle );

sub is_interactive {
    my ($out_handle) = (@_, select);    # Default to default output handle

    # Not interactive if output is not to terminal...
    return 0 if not -t $out_handle;

    # If *ARGV is opened, we're interactive if...
    if (openhandle *ARGV) {
        # ...it's currently opened to the magic '-' file
        return -t *STDIN if defined $ARGV && $ARGV eq '-';

        # ...it's at end-of-file and the next file is the magic '-' file
        return @ARGV>0 && $ARGV[0] eq '-' && -t *STDIN if eof *ARGV;

        # ...it's directly attached to the terminal 
        return -t *ARGV;
    }

    # If *ARGV isn't opened, it will be interactive if *STDIN is attached 
    # to a terminal.
    else {
        return -t *STDIN;
    }
}

local (*DEV_NULL, *DEV_NULL2);
my $dev_null;
BEGIN {
    pipe *DEV_NULL, *DEV_NULL2
        or die "Internal error: can't create null filehandle";
    $dev_null = \*DEV_NULL;
}

sub interactive {
    my ($out_handle) = (@_, \*STDOUT);      # Default to STDOUT
    return &is_interactive ? $out_handle : $dev_null;
}

sub _input_pending_on {
    my ($fh) = @_;
    my $read_bits = "";
    my $bit = fileno($fh);
    return if $bit < 0;
    vec($read_bits, fileno($fh), 1) = 1;
    select $read_bits, undef, undef, 0.1;
    return $read_bits;
}

sub busy (&) {
    my ($block_ref) = @_;

    # Non-interactive busy-ness is easy...just do it
    if (!is_interactive()) {
        $block_ref->();
        open my $fh, '<', \"";
        return $fh;
    }

    # Otherwise fork off an interceptor process...
    my ($read, $write);
    pipe $read, $write;
    my $child = fork;

    # Within that interceptor process...
    if (!$child) {
        # Prepare to send back any intercepted input...
        use IO::Handle;
        close $read;
        $write->autoflush(1);

        # Intercept that input...
        while (1) {
            if (_input_pending_on(\*ARGV)) {
                # Read it...
                my $res = <ARGV>;

                # Send it back to the parent...
                print {$write} $res;

                # Admonish them for not waiting...
                print {*STDERR} "That input was ignored. ",
                                "Please don't press any keys yet.\n";
            }
        }
        exit;
    }

    # Meanwhile, back in the parent...
    close $write;

    # Temporarily close the input...
    local *ARGV;
    open *ARGV, '<', \"";

    # Do the job...
    $block_ref->();

    # Take down the interceptor...
    kill 9, $child;
    wait;

    # Return whatever the interceptor caught...
    return $read;
}

use Carp;

sub import {
    my ($package) = shift;
    my $caller = caller;

    # Export each sub if it's requested...
    for my $request ( @_ ) {
        no strict 'refs';
        my $impl = *{$package.'::'.$request}{CODE};
        croak "Unknown subroutine ($request()) requested"
            if !$impl || $request =~ m/\A _/xms;
        *{$caller.'::'.$request} = $impl;
    }
}


1; # Magic true value required at end of module
__END__

#line 293
